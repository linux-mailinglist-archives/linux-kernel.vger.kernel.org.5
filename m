Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EF87E753B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 00:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345382AbjKIXmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 18:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjKIXmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 18:42:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06463AB7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 15:41:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6806C433C8;
        Thu,  9 Nov 2023 23:41:48 +0000 (UTC)
Date:   Thu, 9 Nov 2023 18:41:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com,
        Oded Gabbay <ogabbay@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Amit Shah <amit@kernel.org>, Gonglei <arei.gonglei@huawei.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Junxian Huang <huangjunxian6@hisilicon.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Helge Deller <deller@gmx.de>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH 85/86] treewide: drivers: remove cond_resched()
Message-ID: <20231109184151.52a9aa33@gandalf.local.home>
In-Reply-To: <ZU1qgv1QNiSJFEOZ@google.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231107230822.371443-1-ankur.a.arora@oracle.com>
        <20231107230822.371443-29-ankur.a.arora@oracle.com>
        <ZU1qgv1QNiSJFEOZ@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2023 15:25:54 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Hi Anhur,
> 
> On Tue, Nov 07, 2023 at 03:08:21PM -0800, Ankur Arora wrote:
> > There are broadly three sets of uses of cond_resched():
> > 
> > 1.  Calls to cond_resched() out of the goodness of our heart,
> >     otherwise known as avoiding lockup splats.  
> 
> ...
> 
> What about RCU stalls? The calls to cond_resched() in evdev.c and
> mousedev.c were added specifically to allow RCU to run in cases when
> userspace passes a large buffer and the kernel is not fully preemptable.
> 

First, this patch is being sent out premature as it depends on acceptance
of the previous patches.

When the previous patches are finished, then we don't need cond_resched()
to protect against RCU stalls, because even "PREEMPT_NONE" will allow
preemption inside the kernel.

What the earlier patches do is introduce a concept of NEED_RESCHED_LAZY.
Then when the scheduler wants to resched the task, it will set that bit
instead of NEED_RESCHED (for the old PREEMPT_NONE version). For VOLUNTARY,
it sets the LAZY bit of SCHED_OTHER but NEED_RESCHED for RT/DL tasks. For
PREEMPT, it will always set NEED_RESCHED.

NEED_RESCHED will always schedule, but NEED_RESCHED_LAZY only schedules
when going to user space.

Now after on tick (depending on HZ it can be 1ms, 3.3ms, 4ms 10ms) if
NEED_RESCHED_LAZY is set, then it will set NEED_RESCHED, forcing a
preemption at the next available moment (when preempt count is zero).

This will be done even with the old PREEMPT_NONE configuration.

That way we will no longer play whack-a-mole to get rid of all he long
running kernel paths by inserting cond_resched() in them.

-- Steve
