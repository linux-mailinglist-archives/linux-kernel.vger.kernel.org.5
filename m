Return-Path: <linux-kernel+bounces-116776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB4588A3C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A43F1C3A545
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B6014D42A;
	Mon, 25 Mar 2024 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdJOxvQj"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421514291F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362715; cv=none; b=pUAjjfB0E+Pkms5h9YcF0HjI5QQdIPoh0YSGoTSB5qeCVacGANR6EQOizpDnc/JZOVsV0JwBmDyDr422ALBowIV70XLxbvojcgtZXnXX+9ygXTMiiGmD9CIMW9NQWFB6PphsVUGkkXoYfxaiULFrjchpZny3j+jRpcADqy/Uz3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362715; c=relaxed/simple;
	bh=Dbdkld9EIn5mxEib8xVsWINte3+ADKN1z1yj3vCs6Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=is2Tcq8F6YnxOQop160tzDTIK90Goyv2BZQQKl/MYlOHcK99p7+CILchdjxHpdSfANfb0qhJGzjCL7nQ3OozTwEqgwQgNED13w6y1zT516jr5OvXx6S1IGgGXOL49H1C5BTQbB033n253Y/+yr+tVC/Tk9f+gF0GD2RxsLeTNAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdJOxvQj; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d6a1ad08b8so57687431fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711362712; x=1711967512; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dbdkld9EIn5mxEib8xVsWINte3+ADKN1z1yj3vCs6Rg=;
        b=fdJOxvQjOuqBc9SlPG/Iv3WsJoOB0of/o04JDnaOPHyL24BQ2bFr+9QbuHS6h6QNtX
         qqckSBI9YDFk0zLEl/DMnMsFw5J3B/TpFDAqlXuquAVSIifAbh+pml1HnJ6fYxHSDg04
         R7Yhwyfr114kyRYc82tCBmZlXMk/J+gGqQRrwHy5URfrdTe5W/n6DHM4bKz+5nKreKAi
         PuIC5r3ZTrQKLaLG/1S24NfaBjupykdHgEKFdTVJZ8vL9OTSJUOh4vHU9f7DZbXf9TaV
         ii3MnkKqHCZ5sbtc/gGA5gRvsV4a2pamSOyEXK0KyxKu0o9olDivzpeK50+2CGk45MG+
         0dEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711362712; x=1711967512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dbdkld9EIn5mxEib8xVsWINte3+ADKN1z1yj3vCs6Rg=;
        b=D+ksiMrrVcyTQdotznVkLShggjOO6FxvlXurVs8I0iq+mD/eGIemZYz9C8LPtl0DBg
         cUn/biIq8KntBC9o2nfjMZwJInpYsXt1HiGZetDqiw+GTj6DHLkQlA68fPLOBJepytIf
         n2UmlQkoSC50AeOQWZSEGZ9j0Hw7b2v1gbpMxA2PVsbCpNzbYVVIDq7dn0UkRp0KUHUc
         q1bEe6CvuE2fFYHdXJz9Q1pSD0aPfMgGT+pgWgdVc249kgBmyqq6+tELiqLTiiG2JWHg
         1wSqkSIfUKRTbKAQQ/p6q/AudNR34rTSuILlhOwY4FZMptnC+bknPhCcJmIiREMnVERQ
         g00w==
X-Forwarded-Encrypted: i=1; AJvYcCUUDTy0pkl73Tr600YakhVX7n3yWQTMtiHVA2TJvA+RsqRLntWaxBqju5AddaUqDbtPwN/3mJSKkJTVf5XPhkFIS4aqbCsuyEs/5hBu
X-Gm-Message-State: AOJu0YxqoKwYceit+ZfntHNDJ6SgewUxW+MovXRvcWOOA3W26Uy6twZw
	Z/pDs7sbD61AvksOptp4Yo5ZokZ5QQzlaqdXdLLwBfhXZrtBFar/tMuEmUiFPFK4UDVdyxtC0+b
	zahi8Wpc6yWGsk3+peeQIjUxDBdLP8VV772YciA==
X-Google-Smtp-Source: AGHT+IEZrrW3vOVJicf/LJWc1jJKfh8xwURLN0NHHA7XVSrGGSYNh2jxYmNV4jLkP8w4dTUVhg8Kf7G/bCr+8tPPfmE=
X-Received: by 2002:a2e:a714:0:b0:2d6:dac4:7d4f with SMTP id
 s20-20020a2ea714000000b002d6dac47d4fmr1068288lje.4.1711362712188; Mon, 25 Mar
 2024 03:31:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403251658.8e92a8bc-lkp@intel.com>
In-Reply-To: <202403251658.8e92a8bc-lkp@intel.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 25 Mar 2024 11:31:40 +0100
Message-ID: <CAFULd4bFbhOQ+mx2=pKqLbLznR-UFZamS4HhdUYZF2qFKNcDVg@mail.gmail.com>
Subject: Re: [linus:master] [x86/percpu] ca42563486: BUG:unable_to_handle_page_fault_for_address
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-mm@kvack.org
Content-Type: multipart/mixed; boundary="0000000000008ad00d061479ae18"

--0000000000008ad00d061479ae18
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 9:50=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
> hi, Uros Bizjak,
>
> we reported an early crash issue for this commit last Oct.
> https://lore.kernel.org/all/202310071301.a5113890-oliver.sang@intel.com/
>
> as you mentioned at that time
> "It is KASAN that is not compatible with named address spaces [1]."
>
> now we noticed the commit is merged into mainline, and we observed a diff=
erent
> issue related with kcsan_setup_watchpoint. below detail report FYI.
>
> [1] https://lore.kernel.org/lkml/CAHk-=3Dwi6U-O1wdPOESuCE6QO2OaPu0hEzaig0=
uDOU4L5CREhug@mail.gmail.com/
>

Yes, it is the same issue, but with KCSAN.

> Hello,
>
> kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" o=
n:
>
> commit: ca4256348660cb2162668ec3d13d1f921d05374a ("x86/percpu: Use C for =
percpu read/write accessors")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [test failed on linus/master b3603fcb79b1036acae10602bffc4855a4b9af80]
> [test failed on linux-next/master 226d3c72fcde130a99d760895ebdd20e78e02cb=
5]
>
> in testcase: boot
>
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 1=
6G

We already have the candidate fix for GCC [1], the fix will be in gcc-13.3+=
.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D111736

Please find attached an emergency patch for mainline that disables
named address spaces when KCSAN is enabled. I'll post a formal patch
submission in a moment. The named AS will be re-enabled with KCSAN
with a patch via -tip tree.

Thanks,
Uros.

--0000000000008ad00d061479ae18
Content-Type: text/plain; charset="US-ASCII"; name="p.diff.txt"
Content-Disposition: attachment; filename="p.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lu6t4s5d0>
X-Attachment-Id: f_lu6t4s5d0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L0tjb25maWcgYi9hcmNoL3g4Ni9LY29uZmlnCmluZGV4IDM5
ODg2YmFiOTQzYS4uNGZmZjZlZDQ2ZTkwIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9LY29uZmlnCisr
KyBiL2FyY2gveDg2L0tjb25maWcKQEAgLTI0MzksNiArMjQzOSw4IEBAIGNvbmZpZyBVU0VfWDg2
X1NFR19TVVBQT1JUCiAJIyB3aXRoIG5hbWVkIGFkZHJlc3Mgc3BhY2VzIC0gc2VlIEdDQyBQUiBz
YW5pdGl6ZXIvMTExNzM2LgogCSMKIAlkZXBlbmRzIG9uICFLQVNBTgorCSMgLWZzYW5pdGl6ZT10
aHJlYWQgKEtDU0FOKSBpcyBhbHNvIGluY29tcGF0aWJsZS4KKwlkZXBlbmRzIG9uICFLQ1NBTgog
CiBjb25maWcgQ0NfSEFTX1NMUwogCWRlZl9ib29sICQoY2Mtb3B0aW9uLC1taGFyZGVuLXNscz1h
bGwpCg==
--0000000000008ad00d061479ae18--

