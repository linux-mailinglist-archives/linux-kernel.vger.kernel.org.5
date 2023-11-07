Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFA87E4BEF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbjKGWka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbjKGWk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:40:27 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96F1D78
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:40:25 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b44befac59so141159b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 14:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699396825; x=1700001625; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qdlfGMkMB+rViUpfGFlOnl1UolkeUbIPfOK1xVkVbcI=;
        b=Bl3aijhEIDsoCz7JvogT71g7y8vrVMqeJ5Jj3PgGEbVbYn1ga1za27XCVqoYW6aEk5
         AQTYjX9wkmyRByQpJhHAiqXtVHjmtQa/yJLGye7Is+0OdUzEgF6RJa4nSHhOcYsq8mX2
         ys/KNCEUDGZwXsx1P5LKMIpYek4zfUc537bpomTCvYSJRi6eoJ7QBleCRNvbTXkZ+6zo
         tfjol8+/R06sU3dzhgj+h2gFJAF0GpUShojM3gAbPAl1EDuUWXcO4FD5pzkFH3PmnpMf
         zm/8vHC+AKUyGQvSPeVa0Zbun0J21bgqZl/v376O3vpu0V5/q0w9aLPPrYsWsCo3nThy
         6h4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699396825; x=1700001625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdlfGMkMB+rViUpfGFlOnl1UolkeUbIPfOK1xVkVbcI=;
        b=fmzXAcoIhTqjbZ5pXnujtFp9xh91kIiPWachcdypzZIJQJOB6yKRsDMUsENMizgAi4
         NbD7nXIZ3opyS3RbM4zGgTO7XnP6nOeL6Dq3JC6IYYaKUrb2gbGS+q/gl39cOY5ju8Bp
         /KJB2SkNNPbK7/2BT+zftwwOtEwoKlRJQpZIweJNvrLXXFvMKkOefq9DrS/Q5Ykvuop1
         YxxOn+xC963LMdYki7FFjb8UJ2p2z6I86szHHZqk51J7uZWGAQIY/TzwM/RB2JBzMCYq
         fzyljHuIM5uPvpLSfzIxKKeBaA+QUqIzZR0cy6/C828AcJkgA1sDGxIM79p89spB/fZC
         S85A==
X-Gm-Message-State: AOJu0YxvsAu9aoQbLOL6yGSB1NghgRJXz2PDn7DEM+cJkOr9PIzlC9Ai
        wLFKbJzjYKRHlvbpU2wrzLDoRw==
X-Google-Smtp-Source: AGHT+IGqpyx9Wghyj39jlL4WXQj6Mzt3LzDaCEDRo0Owa8h8169DVTF3WLb1shX6OdHf1zaFPAyXew==
X-Received: by 2002:a05:6a20:6a20:b0:181:7d6d:c10b with SMTP id p32-20020a056a206a2000b001817d6dc10bmr204445pzk.7.1699396824983;
        Tue, 07 Nov 2023 14:40:24 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id bv130-20020a632e88000000b005bd3d6e270dsm1824393pgb.68.2023.11.07.14.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 14:40:24 -0800 (PST)
Date:   Tue, 7 Nov 2023 14:40:22 -0800
From:   Deepak Gupta <debug@rivosinc.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, pengfei.xu@intel.com
Subject: Re: [PATCH] x86/shstk: Change SSP after user accesses
Message-ID: <ZUq81py010AdTE49@debug.ba.rivosinc.com>
References: <20231107182251.91276-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231107182251.91276-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Deepak Gupta <debug@rivosinc.com>

On Tue, Nov 07, 2023 at 10:22:51AM -0800, Rick Edgecombe wrote:
>When a signal is being delivered, the kernel needs to make accesses to
>userspace. These accesses could encounter an access error, in which case
>the signal delivery itself will trigger a segfault. Usually this would
>result in the kernel killing the process. But in the case of a SEGV signal
>handler being configured, the failure of the first signal delivery will
>result in *another* signal getting delivered. The second signal may
>succeed if another thread has resolved the issue that triggered the
>segfault (i.e. a well timed mprotect()/mmap()), or the second signal is
>being delivered to another stack (i.e. an alt stack).
>
>On x86, in the non-shadow stack case, all the accesses to userspace are
>done before changes to the registers (in pt_regs). The operation is
>aborted when an access error occurs, so although there may be writes done
>for the first signal, control flow changes for the signal (regs->ip,
>regs->sp, etc) are not committed until all the accesses have already
>completed successfully. This means that the second signal will be
>delivered as if it happened at the time of the first signal. It will
>effectively replace the first aborted signal, overwriting the half-written
>frame of the aborted signal. So on sigreturn from the second signal,
>control flow will resume happily from the point of control flow where the
>original signal was delivered.
>
>The problem is, when shadow stack is active, the shadow stack SSP
>register/MSR is updated *before* some of the userspace accesses. This
>means if the earlier accesses succeed and the later ones fail, the second
>signal will not be delivered at the same spot on the shadow stack as the
>first one. So on sigreturn from the second signal, the SSP will be
>pointing to the wrong location on the shadow stack (off by a frame).
>
>Pengfei privately reported that while using a shadow stack enabled glibc,
>the “signal06” test in the LTP test-suite hung. It turns out it is
>testing the above described double signal scenario. When this test was
>compiled with shadow stack, the first signal pushed a shadow stack
>sigframe, then the second pushed another. When the second signal was
>handled, the SSP was at the first shadow stack signal frame instead of
>the original location. The test then got stuck as the #CP from the twice
>incremented SSP was incorrect and generated segfaults in a loop.
>
>Fix this by adjusting the SSP register only after any userspace accesses,
>such that there can be no failures after the SSP is adjusted. Do this by
>moving the shadow stack sigframe push logic to happen after all other
>userspace accesses.
>
>Note, sigreturn (as supposed to the signal delivery dealt with in this
>patch) has ordering behavior that could lead to similar failures. The
>ordering issues there extend beyond shadow stack to include the alt stack
>restoration. Fixing that would require cross-arch changes, and the
>ordering today does not cause any known test or apps breakages. So leave
>it as is, for now.
>
>Cc: stable@vger.kernel.org
>Fixes: 05e36022c054 ("x86/shstk: Handle signals for shadow stack")
>Reported-by: Pengfei Xu <pengfei.xu@intel.com>
>Tested-by: Pengfei Xu <pengfei.xu@intel.com>
>Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>---
> arch/x86/kernel/signal_64.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
>index cacf2ede6217..23d8aaf8d9fd 100644
>--- a/arch/x86/kernel/signal_64.c
>+++ b/arch/x86/kernel/signal_64.c
>@@ -175,9 +175,6 @@ int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
> 	frame = get_sigframe(ksig, regs, sizeof(struct rt_sigframe), &fp);
> 	uc_flags = frame_uc_flags(regs);
>
>-	if (setup_signal_shadow_stack(ksig))
>-		return -EFAULT;
>-
> 	if (!user_access_begin(frame, sizeof(*frame)))
> 		return -EFAULT;
>
>@@ -198,6 +195,9 @@ int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
> 			return -EFAULT;
> 	}
>
>+	if (setup_signal_shadow_stack(ksig))
>+		return -EFAULT;
>+
> 	/* Set up registers for signal handler */
> 	regs->di = ksig->sig;
> 	/* In case the signal handler was declared without prototypes */
>-- 
>2.34.1
>
