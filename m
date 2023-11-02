Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9227A7DF6C4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376808AbjKBPp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbjKBPp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:45:28 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CE413D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:45:21 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1e9bb3a0bfeso668495fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 08:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698939920; x=1699544720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=811Wbdi3WkqjCSZVVfz56NC98wHZL/lpCPsLeMoBGy0=;
        b=0kg7n8X8uDaxlInsv3TBEIU8cEAcTVkuXkye0q1FGeHbj+kmJex6jFJLyKRomzi5KV
         c0UMIZAukJcsyJ9PgrM9i1OqisDt95wTBbO2N08ZjwRcjAhXB9yVKtc3C8+u4X2quDxW
         Fbg0QKuMXzJBweq5WqXsmSdj/BW1Qq22cjJyt2U1wCQ4P2IPi4VFAVBra26gHxxHOINm
         Ipt6HDXMRYeJ9ZkSSduFDyxL0wm/k+eaTT0WJrWgdSPs5VEK/yjw/hHaodmf0Rbm3ffP
         mp09/T6NALaeNuNzd0GtIK1khD6kNsAyp2AVeP1R/dgmA5miwrzMTFCYhluiZviIP+MU
         itvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698939920; x=1699544720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=811Wbdi3WkqjCSZVVfz56NC98wHZL/lpCPsLeMoBGy0=;
        b=eJcAJ/yiatby9dv3OxsSIMWvICXpflxKKLw3LIgSnjkj7jhtIl5Xj3prpIxeo+JjKU
         H5tiRul9CEBIC9IycJO4t1fG7ynL7GSOyXvZLk65TxFYBwstpTxWCBh6qsDTvGJfcbyk
         bAygVRG9yh7JiyGEqdWPB+Fs1WTCcui16M58glrEJASgXeMmc2/bu5D3Lmd0fappW/ah
         rY+ZzurOpMPdbXq9XBde3AN+uqDO88Np7KW4nOyA+UhzA+T8zo2Qfy/AyiHGHls45q7G
         kMPhgMqaVEF6tJcCoqusoAXX/MsfQO8gkiMUJU9f2TgjySWvcu0F7wEwCbEXNGH5y7nw
         u2ew==
X-Gm-Message-State: AOJu0YwBJFuScE66SPtnvvppkLYfoZUuMfZyC2d9uCikEZmgAgWWgjKb
        GVOk3NqczsqZ9DhqZh3AUQdiLg==
X-Google-Smtp-Source: AGHT+IG10P/+TWcEKjiYtSWM4kwAWWHLTtonpxdD387OxExmncHkv81To7NNOZz4Z98YE/IefdevkA==
X-Received: by 2002:a05:6870:582:b0:1e9:b495:bd0 with SMTP id m2-20020a056870058200b001e9b4950bd0mr21253823oap.8.1698939920178;
        Thu, 02 Nov 2023 08:45:20 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ds42-20020a0568705b2a00b001e98fa5c9edsm604940oab.40.2023.11.02.08.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 08:45:19 -0700 (PDT)
Date:   Thu, 2 Nov 2023 08:45:17 -0700
From:   Deepak Gupta <debug@rivosinc.com>
To:     woodrow.shen@sifive.com, Andrew Jones <ajones@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Glenn Washburn <development@efficientek.com>,
        Jeff Xie <xiehuan09@gmail.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     akpm@linux-foundation.org
Subject: Re: [PATCH v6] scripts/gdb: add lx_current support for riscv
Message-ID: <ZUPEDWofcqgzsgMS@debug.ba.rivosinc.com>
References: <20231026233837.612405-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231026233837.612405-1-debug@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping

+ CC: akpm@linux-foundation.org

Who should I ping to make sure that it lands up in mainline?
It's quite a trivial change to support lx_current riscv arch.

-Deepak

On Thu, Oct 26, 2023 at 04:38:23PM -0700, Deepak Gupta wrote:
>csr_sscratch CSR holds current task_struct address when hart is in
>user space. Trap handler on entry spills csr_sscratch into "tp" (x2)
>register and zeroes out csr_sscratch CSR. Trap handler on exit reloads
>"tp" with expected user mode value and place current task_struct address
>again in csr_sscratch CSR.
>
>This patch assumes "tp" is pointing to task_struct. If value in
>csr_sscratch is numerically greater than "tp" then it assumes csr_sscratch
>is correct address of current task_struct. This logic holds when
>   - hart is in user space, "tp" will be less than csr_sscratch.
>   - hart is in kernel space but not in trap handler, "tp" will be more
>     than csr_sscratch (csr_sscratch being equal to 0).
>   - hart is executing trap handler
>       - "tp" is still pointing to user mode but csr_sscratch contains
>          ptr to task_struct. Thus numerically higher.
>       - "tp" is  pointing to task_struct but csr_sscratch now contains
>          either 0 or numerically smaller value (transiently holds
>          user mode tp)
>
>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
>Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>Tested-by: Hsieh-Tseng Shen <woodrow.shen@sifive.com>
>
>---
>Since patch has changed a little bit from v1 and I didn't include
>changelog earlier, here it is.
>
>v1 --> v2:
> - added logic to locate task_struct irrespective of priv
> - made locating task_struct agnostic to bitness(32 vs 64).
> - added caching of ulong type in scripts/gdb/linux/utils.py
> - added more descriptive commit message
>
>v2 --> v3:
> - amended commit message and source line to fit column width
>
>v3 --> v4:
> - amended commit message and remove whitespace in source
> - added Reviewed-by for reviewers
>
>v4 --> v5:
> - changing the order of changelog and sign off/review tags in commit
>
>v5 --> v6:
> - rebased on 6.6-rc5. dropped changes in utils.py as they're upstream
>---
> scripts/gdb/linux/cpus.py | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>
>diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
>index 255dc18cb9da..cba589e5b57d 100644
>--- a/scripts/gdb/linux/cpus.py
>+++ b/scripts/gdb/linux/cpus.py
>@@ -179,6 +179,21 @@ def get_current_task(cpu):
>         else:
>             raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
>                                "while running in userspace(EL0)")
>+    elif utils.is_target_arch("riscv"):
>+        current_tp = gdb.parse_and_eval("$tp")
>+        scratch_reg = gdb.parse_and_eval("$sscratch")
>+
>+        # by default tp points to current task
>+        current_task = current_tp.cast(task_ptr_type)
>+
>+        # scratch register is set 0 in trap handler after entering kernel.
>+        # When hart is in user mode, scratch register is pointing to task_struct.
>+        # and tp is used by user mode. So when scratch register holds larger value
>+        # (negative address as ulong is larger value) than tp, then use scratch register.
>+        if (scratch_reg.cast(utils.get_ulong_type()) > current_tp.cast(utils.get_ulong_type())):
>+            current_task = scratch_reg.cast(task_ptr_type)
>+
>+        return current_task.dereference()
>     else:
>         raise gdb.GdbError("Sorry, obtaining the current task is not yet "
>                            "supported with this arch")
>-- 
>2.42.0
>
