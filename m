Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7C87FACD3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjK0VyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjK0VyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:54:21 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E317AC1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:54:27 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so822a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701122066; x=1701726866; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i5GFJDUW3MHlNrfhyC5VB4ESUR3+JVE/rcjBTTcA06g=;
        b=uey2PQoqD4VqWR8DtFOJQMKnRAkh4NFPlOJ3yMXBQmMtS9eqfTKTaY8QyL1tfVAnUu
         mPBZSZvZ8boQx9NASvxQKy2fsIBX2jUiEFiURbV40NQsVowO65V7qhBeWjhQ/OQ29S/Q
         J0qjgPfBPiMsgYY8RNMykYngpX/Ls5cA5pGvFTC6if3jIfNHxCFvOV/Aw7P8g5EpVwV+
         R+CV+PviWjPc4H76jaYqvMR+FIjZTotb5MkD+k5ADWS68ZaTwchqv8se44BS64VP9Q94
         DM4sP5BOyocPYpyBiJEdTArDxmdjV17fpkalTPSLeJmFqtSBz2L2VZ5Tt1QxjnH5aCZ5
         UbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701122066; x=1701726866;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i5GFJDUW3MHlNrfhyC5VB4ESUR3+JVE/rcjBTTcA06g=;
        b=mgWVFgoKupTnsGL3EC3iS9XkSdqD3sZBofIMNW8YmG4Xr/IgZ37fLSciy83UeN3Xvu
         zxTaiwlluR+h8SfX35CUoxET5o+V0fLkrQpteipKxfryQJp+Ld3jf/jNLtrc5oBuy+6h
         155KfiSIYbW7WUHtNVMfNA57ixUjRk6/HCWE+JVVOz70UySde9Ocyp/N2K7+bVukv1AG
         kS696kt1VFIE1XkrySQUXhjTQ40+fP4a8jilv1qcHCRZg5HSy/V/GwjaT0d5V8Fk0m2f
         PiMxkfLbU2lCvYMWBFSabQK1TSPZ5RZNLO1jBfZLJxSR0TEkwZi2h4lHWjBkSaawuKyr
         EpmQ==
X-Gm-Message-State: AOJu0Yw1Lc/iZ3PwY2BqFGjBRwCRXWBubqO5sViIA9RHIJQhTITVXMG5
        KAhFeVlAtFaTIIctonj5QCthpL0ZMQJ2kN/bM8q2EKXT3jmG6ovtNWaROBqB
X-Google-Smtp-Source: AGHT+IG7xZ4KRyQfbbBd9eQ/dnxxRH3eLZSxxvhqaJC/Su/40gRFks8qp3gsssLJI7cZhsC77GdZ4vin2Uj+daxlTvI=
X-Received: by 2002:a05:6402:3510:b0:54b:2abd:ad70 with SMTP id
 b16-20020a056402351000b0054b2abdad70mr280820edd.7.1701122066260; Mon, 27 Nov
 2023 13:54:26 -0800 (PST)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Mon, 27 Nov 2023 22:53:48 +0100
Message-ID: <CAG48ez1htVSO3TqmrF8QcX2WFuYTRM-VZ_N10i-VZgbtg=NNqw@mail.gmail.com>
Subject: io_uring: risky use of task work, especially wrt fdget()
To:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring <io-uring@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I noticed something that I think does not currently cause any
significant security issues, but could be problematic in the future:

io_uring sometimes processes task work in the middle of syscalls,
including between fdget() and fdput(). My understanding of task work
is that it is expected to run in a context similar to directly at
syscall entry/exit: task context, no locks held, sleeping is okay, and
it doesn't execute in the middle of some syscall that expects private
state of the task_struct to stay the same.

An example of another user of task work is the keyring subsystem,
which does task_work_add() in keyctl_session_to_parent() to change the
cred pointers of another task.

Several places in io_uring process task work while holding an fdget()
reference to some file descriptor. For example, the io_uring_enter
syscall handler calls io_iopoll_check() while the io_ring_ctx is only
referenced via fdget(). This means that if there were another kernel
subsystem that uses task work to close file descriptors, io_uring
would become unsafe. And io_uring does _almost_ that itself, I think:
io_queue_worker_create() can be run on a workqueue, and uses task work
to launch a worker thread from the context of a userspace thread; and
this worker thread can then accept commands to close file descriptors.
Except it doesn't accept commands to close io_uring file descriptors.

A closer miss might be io_sync_cancel(), which holds a reference to
some normal file with fdget()/fdput() while calling into
io_run_task_work_sig(). However, from what I can tell, the only things
that are actually done with this file pointer are pointer comparisons,
so this also shouldn't have significant security impact.

Would it make sense to use fget()/fput() instead of fdget()/fdput() in
io_sync_cancel(), io_uring_enter and io_uring_register? These
functions probably usually run in multithreaded environments anyway
(thanks to the io_uring worker threads), so I would think fdget()
shouldn't bring significant performance savings here?
