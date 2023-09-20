Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EEF7A8F37
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 00:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjITWUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 18:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjITWUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 18:20:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7F7C9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 15:20:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38237C433C7;
        Wed, 20 Sep 2023 22:19:59 +0000 (UTC)
Date:   Wed, 20 Sep 2023 18:20:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>, chinglinyu@google.com,
        lkp@intel.com, namit@vmware.com, oe-lkp@lists.linux.dev,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: Re: [PATCH 1/2 v3] eventfs: Remove eventfs_file and just use
 eventfs_inode
Message-ID: <20230920182035.2f2dde44@gandalf.local.home>
In-Reply-To: <20230919211804.230edf1e@gandalf.local.home>
References: <20230914163504.884804272@goodmis.org>
        <20230914163535.269645249@goodmis.org>
        <20230919000129.be4971c111300d108be97a3f@kernel.org>
        <20230918210456.3772d4fa@gandalf.local.home>
        <20230919184109.d2382bccfc208676c64df3fb@kernel.org>
        <20230919211804.230edf1e@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/EXe79q9NtBArYHFv+E1tow4"
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/EXe79q9NtBArYHFv+E1tow4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 19 Sep 2023 21:18:04 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Hmm, actually looking at this, it's worse than what you stated. This is
> called when a directory is closed. So if you had:
> 
> 	open(dir);
> 
> 	// look at all the content of this dir to create dentries
> 
> 	// another task creates a new entry and looks at it too.
> 
> 	close(dir);
> 
> Now we iterate over all the dentries of the dir and dput it.
> 
> I think this will cause the ref counts to get out of sync. I'll have to try
> to create this scenario and see what happens.

And yes it does break :-p

Even without this patch it breaks. That is, this bug exists currently upstream.

I run the attached file (requires libtracefs)

and then run:

  # cd /sys/kernel/tracing
  # echo 99999999 > buffer_size_kb&

Wait a bit.

This will cause the ref counts to go negative.

Then do a: trace-cmd reset

Which will remove the kprobes created by the attached program, and will
crash the kernel :-p

I have an idea on how to fix it. Let my try it out.

-- Steve

--MP_/EXe79q9NtBArYHFv+E1tow4
Content-Type: text/x-c++src
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=test_eventfs_dir.c

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <getopt.h>
#include <errno.h>
#include <unistd.h>
#include <tracefs.h>

static char *argv0;

static char *get_this_name(void)
{
	static char *this_name;
	char *arg;
	char *p;

	if (this_name)
		return this_name;

	arg = argv0;
	p = arg+strlen(arg);

	while (p >= arg && *p != '/')
		p--;
	p++;

	this_name = p;
	return p;
}

static void usage(void)
{
	char *p = get_this_name();

	printf("usage: %s [-c comm] trace.dat\n"
	       "\n"
	       "  Run this after running: trace-cmd record -e sched\n"
	       "\n"
	       "  Do some work and then hit Ctrl^C to stop the recording.\n"
	       "  Run this on the resulting trace.dat file\n"
	       "\n"
	       "-c comm - to look at only a specific process called 'comm'\n"
	       "\n",p);
	exit(-1);
}

static void __vdie(const char *fmt, va_list ap, int err)
{
	int ret = errno;
	char *p = get_this_name();

	if (err && errno)
		perror(p);
	else
		ret = -1;

	fprintf(stderr, "  ");
	vfprintf(stderr, fmt, ap);

	fprintf(stderr, "\n");
	exit(ret);
}

void die(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	__vdie(fmt, ap, 0);
	va_end(ap);
}

void pdie(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	__vdie(fmt, ap, 1);
	va_end(ap);
}

int main (int argc, char **argv)
{
	int dfd;
	int ret;

	ret = tracefs_kprobe_raw(NULL, "kp1", "schedule_timeout", "time=$arg1");
	if (ret < 0)
		pdie("Can't create schedule_timeout kprobe");

	dfd = tracefs_instance_file_open(NULL, "events/kprobes", O_RDONLY);
	if (dfd < 0)
		pdie("Can't open events/kprobes");

	if (!tracefs_file_exists(NULL, "events/kprobes/kp1/enable"))
		pdie("kp1/enable does not exist");

	ret = tracefs_kprobe_raw(NULL, "kp2", "schedule_hrtimeout", "expires=$arg1");
	if (ret < 0)
		pdie("Can't create schedule_hrtimeout kprobe");

	if (!tracefs_file_exists(NULL, "events/kprobes/kp2/enable"))
		pdie("kp2/enable does not exist");

	close(dfd);

//	tracefs_dynevent_destroy_all(TRACEFS_DYNEVENT_KPROBE, true);

	return 0;
}

--MP_/EXe79q9NtBArYHFv+E1tow4--
