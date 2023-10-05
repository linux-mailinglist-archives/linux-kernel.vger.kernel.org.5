Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E508F7B9F57
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjJEOVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbjJEOTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:19:17 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EA95243
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 22:29:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c5cd27b1acso4255785ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 22:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1696483775; x=1697088575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7J22K+kkq04iFIr8U/rDD0YSRimKRS/5/Okw8x5uY0c=;
        b=YDfYhk0Z3OY/IKRkDkh9U+1NqruhBa8bCndqtK7pLsI9HTDmGm2fTPtTp/3PE9aCl9
         mX1+i5V6IpDCqLDqnvveYt5ObpQb4I2fVvFzO1OpP2VjcPBLj2SjVMsQFB626F5xSUb9
         jn8TKszJWWg6lwiYP714bcdbPW85HaTHBxQpiEqs/o12pHwcIfzNTqAwDTqopq50kZCb
         KWE0bK+cexiqQVWFVC1cgFW1cYx5Pb/Lpidx53MAJ7WURnX8my3mOVyjIJDa0eTn0SKR
         nfCiqdQk0ivLE8RQ7jJ7gtDLktwZLusCK61+/V6flrHajQAYFSil021Em7P8lOYJzwqY
         hHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696483775; x=1697088575;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7J22K+kkq04iFIr8U/rDD0YSRimKRS/5/Okw8x5uY0c=;
        b=azoKgyjC38lrzFvNgljI6qUdl8HcGAi8C2XC8uEfgTMbNliJqRKUbXkEvXup1Tja/y
         a+g11RO1FuQtkNv9KVXDd/r9+0cw5eWksRbpuPrcepzqVhUKkUed+BM1qZCVQLRpXU0S
         yzpwH5k0tkIgoqp7GUaUckUJPMlDYUkYWOIWnVHqll5VOQxxw+BkaVgk10MGwlPY+8ED
         gR4J7wGzpHfckCUHQen2fcoWZYot50TwpRxANRGbcVAadIBUd+yV+Rq9qAqeTxiy1CuP
         MDmOYOaBoECEZinbHglJYCLDKSecYmh7OqenkbZIsPteeS3lmvvcCAIwJkbgRuagi0ta
         YewQ==
X-Gm-Message-State: AOJu0YzcMAMUwhXwnhEwJv7S0NF4x+1auB4Xe+uMjsAu/X2gGozye04J
        qh+XJvRtQUoysrzZpFNZlheH
X-Google-Smtp-Source: AGHT+IG2LgHniXqfqGiAoclAX5CoktHo0eFuP8765KXoQxH4N3w/aCvPlKjQ2Kbuv/+QXZlS0XWNTA==
X-Received: by 2002:a17:902:f688:b0:1c6:3228:c2ca with SMTP id l8-20020a170902f68800b001c63228c2camr5549774plg.29.1696483775226;
        Wed, 04 Oct 2023 22:29:35 -0700 (PDT)
Received: from localhost (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902ee5500b001c3267ae317sm576756plo.165.2023.10.04.22.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 22:29:34 -0700 (PDT)
Date:   Thu, 5 Oct 2023 13:29:32 +0800
From:   Hsieh-Tseng Shen <woodrow.shen@sifive.com>
To:     debug@rivosinc.com
Cc:     palmer@dabbelt.com, ajones@ventanamicro.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, jan.kiszka@siemens.com,
        kbingham@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, paul.walmsley@sifive.com
Subject: Re: [PATCH v5] scripts/gdb: add lx_current support for riscv
Message-ID: <ZR5JvCSDZwTQAucC@u-NUC7i5BNH>
Reply-To: 20221115221051.1871569-1-debug@rivosinc.com
References: <d65bddf3-c58a-1420-bff9-8333c10edb56@microchip.com>
 <20221115221051.1871569-1-debug@rivosinc.com>
 <98eb5bc7-dee4-b36e-a219-17b1e08d85f6@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98eb5bc7-dee4-b36e-a219-17b1e08d85f6@siemens.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 10:09:01AM +0100, Jan Kiszka wrote:
> On 15.11.22 23:10, Deepak Gupta wrote:
> > csr_sscratch CSR holds current task_struct address when hart is in
> > user space. Trap handler on entry spills csr_sscratch into "tp" (x2)
> > register and zeroes out csr_sscratch CSR. Trap handler on exit reloads
> > "tp" with expected user mode value and place current task_struct address
> > again in csr_sscratch CSR.
> > 
> > This patch assumes "tp" is pointing to task_struct. If value in
> > csr_sscratch is numerically greater than "tp" then it assumes csr_sscratch
> > is correct address of current task_struct. This logic holds when
> >    - hart is in user space, "tp" will be less than csr_sscratch.
> >    - hart is in kernel space but not in trap handler, "tp" will be more
> >      than csr_sscratch (csr_sscratch being equal to 0).
> >    - hart is executing trap handler
> >        - "tp" is still pointing to user mode but csr_sscratch contains
> >           ptr to task_struct. Thus numerically higher.
> >        - "tp" is  pointing to task_struct but csr_sscratch now contains
> >           either 0 or numerically smaller value (transiently holds
> >           user mode tp)
> > 
> > Patch also adds new cached type "ulong" in scripts/gdb/linux/utils.py
> > 
> > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > 
> > ---
> > Since patch has changed a little bit from v1 and I didn't include
> > changelog earlier, here it is.
> > 
> > v1 --> v2:
> >  - added logic to locate task_struct irrespective of priv
> >  - made locating task_struct agnostic to bitness(32 vs 64).
> >  - added caching of ulong type in scripts/gdb/linux/utils.py
> >  - added more descriptive commit message
> > 
> > v2 --> v3:
> >  - amended commit message and source line to fit column width
> > 
> > v3 --> v4:
> >  - amended commit message and remove whitespace in source
> >  - added Reviewed-by for reviewers
> > 
> > v4 --> v5:
> >  - changing the order of changelog and sign off/review tags in commit
> > ---
> > ---
> >  scripts/gdb/linux/cpus.py  | 15 +++++++++++++++
> >  scripts/gdb/linux/utils.py |  5 +++++
> >  2 files changed, 20 insertions(+)
> > 
> > diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
> > index 15fc4626d236..14c22f82449b 100644
> > --- a/scripts/gdb/linux/cpus.py
> > +++ b/scripts/gdb/linux/cpus.py
> > @@ -173,6 +173,21 @@ def get_current_task(cpu):
> >           else:
> >               raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
> >                                  "while running in userspace(EL0)")
> > +    elif utils.is_target_arch("riscv"):
> > +         current_tp = gdb.parse_and_eval("$tp")
> > +         scratch_reg = gdb.parse_and_eval("$sscratch")
> > +
> > +         # by default tp points to current task
> > +         current_task = current_tp.cast(task_ptr_type)
> > +
> > +         # scratch register is set 0 in trap handler after entering kernel.
> > +         # When hart is in user mode, scratch register is pointing to task_struct.
> > +         # and tp is used by user mode. So when scratch register holds larger value
> > +         # (negative address as ulong is larger value) than tp, then use scratch register.
> > +         if (scratch_reg.cast(utils.get_ulong_type()) > current_tp.cast(utils.get_ulong_type())):
> > +             current_task = scratch_reg.cast(task_ptr_type)
> 
> Why not if-else for the assignment here?
> 
> > +
> > +         return current_task.dereference()
> >      else:
> >          raise gdb.GdbError("Sorry, obtaining the current task is not yet "
> >                             "supported with this arch")
> > diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
> > index 1553f68716cc..ddaf3089170d 100644
> > --- a/scripts/gdb/linux/utils.py
> > +++ b/scripts/gdb/linux/utils.py
> > @@ -35,12 +35,17 @@ class CachedType:
> >  
> >  
> >  long_type = CachedType("long")
> > +ulong_type = CachedType("ulong")
> >  atomic_long_type = CachedType("atomic_long_t")
> >  
> >  def get_long_type():
> >      global long_type
> >      return long_type.get_type()
> >  
> > +def get_ulong_type():
> > +    global ulong_type
> > +    return ulong_type.get_type()
> > +
> >  def offset_of(typeobj, field):
> >      element = gdb.Value(0).cast(typeobj)
> >      return int(str(element[field].address).split()[0], 16)
> 
> Looks good to me otherwise.
> 
> Jan
> 
> -- 
> Siemens AG, Technology
> Competence Center Embedded Linux

This patch had been pending for quite a while, and not sure if it's
still acceptable to be merged, but from my testing it's working fine
for me. Nevertheless, the v5 patch now has conflict with the current
master, so I've slightly modified for reference. It would be helpful
if Deepak can send v6 later on.

Tested-by: Hsieh-Tseng Shen <woodrow.shen@sifive.com>

v5 --> v6:
 - dropped cache type "ulong" in scripts/gdb/linux/utils.py as it
 already exists in the current upstream
---
 scripts/gdb/linux/cpus.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 255dc18cb9da..f8325cab5f1b 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -179,6 +179,21 @@ def get_current_task(cpu):
         else:
             raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
                                "while running in userspace(EL0)")
+    elif utils.is_target_arch("riscv"):
+        current_tp = gdb.parse_and_eval("$tp")
+        scratch_reg = gdb.parse_and_eval("$sscratch")
+
+        # by default tp points to current task
+        current_task = current_tp.cast(task_ptr_type)
+
+        # scratch register is set 0 in trap handler after entering kernel.
+        # When hart is in user mode, scratch register is pointing to task_struct.
+        # and tp is used by user mode. So when scratch register holds larger value
+        # (negative address as ulong is larger value) than tp, then use scratch register.
+        if (scratch_reg.cast(utils.get_ulong_type()) > current_tp.cast(utils.get_ulong_type())):
+            current_task = scratch_reg.cast(task_ptr_type)
+
+            return current_task.dereference()
     else:
         raise gdb.GdbError("Sorry, obtaining the current task is not yet "
                            "supported with this arch")
--
2.31.1

Thank you
