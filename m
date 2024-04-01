Return-Path: <linux-kernel+bounces-126548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD4A893957
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BD59B217D5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E826E107B2;
	Mon,  1 Apr 2024 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ya1I+3Fl"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913DADDB6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711963330; cv=none; b=i+o5CUp6mN59NKXB94BIR07ESeCwr8pWTzhbg+j5BdwdIp6o4xrPMN0pihELsHkY6oTXt/L8Dm1CZrngdw/kEayIykBJ6VItXWT7CnH6iOJfE0ihvHIP6mAYZzjJ9O99mFzODubBoK/rDGJ9DjDgxwRhsw3X4rJQsxCHtQH1lKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711963330; c=relaxed/simple;
	bh=GSVXEStJNMGpvr7TAsH4ARvQbzpEQfnc/S5JofY958I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dpojx3tuePsAf8Nv3HS37BI84tvPu3e/EvaiDnWWZKr5hrZ09IPFpzguB396bS5f+OVbvD4+5EKVOhywKkaBNEc04GNPsrscyyjzOm1AQWNHk68na+sukRMLRWGBj1esvG1xjRpbBD8uBCmKODrdREqyLcq1xKWPwaRWw8YTYc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ya1I+3Fl; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-515a81928a1so6150852e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 02:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711963327; x=1712568127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoKRupfTK4Va8twlK+MFQHx3q2WwCC/n+qoReimCgfw=;
        b=Ya1I+3FlbT8NnvfbSY+Qx3bflYsyxp6k+/h47IiJubtYuwV0YgRL5ueiW7wuBIy515
         CgJHtTzEwiunttkTuLtSF/wuOtkKehIeszCWmeomUOL9KdZCzFMZ9lvBkL3fEQJZYxoR
         b0CkRYGrhBG7PyKCMCz25D4cti/+7L1TqqeXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711963327; x=1712568127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GoKRupfTK4Va8twlK+MFQHx3q2WwCC/n+qoReimCgfw=;
        b=TD72nvAwkvZLiEuiZm1/ytbNBvjGHAEhCbhGwuS7wDmFbE8k8uD5SIQRzsh+qKAUZX
         d6JLfX5V6cYTeoSoVa5bqOoDM/EzYghfs39O4vXoZtHt2Tgqs7dZHzaa4dxgFMV4K5HZ
         uHNQSdlmqulPmyhglTrhGb2qwQmFTcKxPam/RIoJfCJpZUzz9D9/iQl5GZZ8dbCBedZk
         QbPTP65mqGrkdNiSgnwNqWkpYjip5P4jSRRVINUvASIX3cr5WVeSnWrbrZtfBn4YjFZY
         MOWuHRRFNyscsu00ozcFP6NMy6LTiMV/3hj+ijrV0iF4Z2GSUl5u7gCkragYA1YqER5A
         YTuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwzafkAVdG/w1YYpMSkShlStnPA9UEtJAfBQpsIkD+HrEW3K+Eziekn7+kTLhYjZ8Z5soqN5Q+E/en2aHrOmJ9V4eZX9AZP7/EQc6q
X-Gm-Message-State: AOJu0YwtAAQ3HmosGYwKmbeVWufqgqtWUL1j8HC4at5GFDBFsqoPM+WV
	kBit/YzhhIXIkdXFPRG5EQtJ0bVfCZbbQRA3h/14jxz2nEbV0TiNZdPHMUrgYDjWrUQrcoB0qpj
	Y8DQNZNKt++L+/OVupcHRFX7Qlo8Tkg2IFOq3
X-Google-Smtp-Source: AGHT+IGiFvWbOA1VyZ55Hsox9CkDx02TTPb/sWdvz92Q64Wdznn28ZE1w6EZRiY1EOXcq4LfpD86tlCCjUVz3neaShk=
X-Received: by 2002:ac2:52b0:0:b0:516:a2ee:71df with SMTP id
 r16-20020ac252b0000000b00516a2ee71dfmr3334289lfm.50.1711963326793; Mon, 01
 Apr 2024 02:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329191208.88821-1-kuntal.nayak@broadcom.com> <2024033014-deception-cartoon-7470@gregkh>
In-Reply-To: <2024033014-deception-cartoon-7470@gregkh>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Mon, 1 Apr 2024 14:51:55 +0530
Message-ID: <CAD2QZ9aJtFpXWYRVmgJRjad6qXXECvi+-J++QAR2t4opa6cdUA@mail.gmail.com>
Subject: Re: [PATCH v4.19-v5.4] vt: fix memory overlapping when deleting chars
 in the buffer
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Kuntal Nayak <kuntal.nayak@broadcom.com>, stable@vger.kernel.org, jslaby@suse.com, 
	linux-kernel@vger.kernel.org, alexey.makhalov@broadcom.com, 
	vasavi.sirnapalli@broadcom.com, Yangxi Xiang <xyangxi5@gmail.com>, 
	stable <stable@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 2:37=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Mar 29, 2024 at 12:12:08PM -0700, Kuntal Nayak wrote:
> > From: Yangxi Xiang <xyangxi5@gmail.com>
> >
> > [ upstream commit 39cdb68c64d8 ]
>
> Please use the full git id in the future, it makes it easier and our
> tools want it that way so that we can tell the difference between a
> "Fixes:" tag and an actual backport.  I'll go queue this up now, thanks!
>

Thanks Greg for accepting the patch.

/scripts/checkpatch.pl confuse developers, as it gives error/warning
if we use full git id.

Example:
ERROR: Please use git commit description style 'commit <12+ chars of
sha1> ("<title line>")' - ie: 'commit e26d3009efda ("netfilter:
nf_tables: disallow timeout for anonymous sets")'
#6:
commit e26d3009efda338f19016df4175f354a9bd0a4ab upstream.

Or shall we have something ./scripts/checkpatchstable.pl or
/scripts/checkpatch.pl stable (pass argument)?

-Ajay

