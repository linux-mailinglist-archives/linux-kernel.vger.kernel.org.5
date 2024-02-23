Return-Path: <linux-kernel+bounces-78639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3606861645
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F381F25DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC9082D6D;
	Fri, 23 Feb 2024 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2wFgqAI"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D9582879
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703393; cv=none; b=r0yHfwJem3wkKFEXvbWGMemUOVnJPg8qQyEVWvVarHeQchYZVJ5OzXRcygGwDiglaOMIZ+0Nf9ejlSWwHtd+4ldf2QG5NxmT/kRgbBzdG0llEWr64Ti1cIx+SDnBoUW8IaLeMMR/nGrGxqzkxSU5K6O2dsx/5N6lHKwff6LKY70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703393; c=relaxed/simple;
	bh=CBBcdxAsqneAyVVkHIegavma0SsIf9UoDOrkni8Cgb0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jyd2q5HiHV56VjjLn8kFafYmZAVUREKjz1VOx5i4XZ4bBecBBTclXS+35HdIdFJ7RqzjI14WoZhg7ZPsgL8Qg4WudCOGS154Qtgeo46bpNKaXjklj89xXgBLrmGengPjlmiDfolmNncI53WKsu0WYgZXcYLggFw9NufLWWrg4BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2wFgqAI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d6cc6d2fcso437534f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 07:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708703390; x=1709308190; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBBcdxAsqneAyVVkHIegavma0SsIf9UoDOrkni8Cgb0=;
        b=Y2wFgqAILKDauBAWF6lQ4WmHbLBtINNJvFBgRAkB3/dJjvbzkLGA2opmViqDoF6Zy1
         D5sRlvS+Wk/3h6BFFOI6YFyUCEEkbjvlF0d+tBUUPpcVaCudtV6UOtIOJH57k1MT5dCp
         I/RFxw7uw+WmCFuVDAmS3IUfI8lnD7aZ6E4niFpnpP5wQiEHgAddVFytUwaF/i+AXgGk
         IDmfL9MbTtHBgMdmRZVdAtCf4lN0fbZO+Caw0wSsPxYhvPLa9ldYharJJiO8XYhef6ih
         G7bBDLLvmyLIDOjEgqgP742DDQ1KYU+1z0iugAOy2X1B7ouLdgk1agZaH34146Et6DAI
         uzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708703390; x=1709308190;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBBcdxAsqneAyVVkHIegavma0SsIf9UoDOrkni8Cgb0=;
        b=RMpc5wuNegwZANp8ofmvFj4FWPJIw7+7O42Lm+TiwTMg7hnwShy1tjUaw+THylUU90
         vX+w0AlaEr300rZsY/TchihGYHRtR3qvc+i2zfztVskiNcFbADGZHnW4IHAdSVUKsYgu
         Is/SO8kEVnDdXfSa1JjDIsOVqXTP/PGGpsmzM4hIcfGo7iJpJ98uGf3VpVvzZ+4YLm7A
         YLvwPVNkX2XMcUuyh5mDlkjoC379QQByRv0SLFwxsZArqKj978SMUoYjj7gnA97GM/l4
         C6ymkNHMTQ6CF9C+JDVwSa2ou1r0gavohtIz4KYhV3ybpfSzpcm1t9WW9ie8jt1YbtBR
         7hDw==
X-Forwarded-Encrypted: i=1; AJvYcCUvGjaSAGijBjQ5u0rIrY9YH8FdFSgUY5B67JIPZjs24RtKTTNKjwVVFxdt9cDmUaZvuVN+l0pAXmo/aDpbK7ucFb1CZU93KDRh4/03
X-Gm-Message-State: AOJu0YztaGBYN/inMygNbTcQ8c/Too5OHV3Xmf2NUNBi5STCBQEcCfb8
	/hxChAjGiJxFMoOXcCltgNCaRnCgwe1zmrr/MO8O/8SoFz/Ob8ME
X-Google-Smtp-Source: AGHT+IE6jWAXTaROgPlOpsfb0NCtVxsObxPTAO36QFMXxeIzNwihlJL1OwdIzMInqhFQ9U1yUv0W5A==
X-Received: by 2002:a5d:4b4f:0:b0:33d:af8b:6b79 with SMTP id w15-20020a5d4b4f000000b0033daf8b6b79mr157857wrs.6.1708703389655;
        Fri, 23 Feb 2024 07:49:49 -0800 (PST)
Received: from smtpclient.apple ([77.137.71.62])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d4389000000b0033cf095b9a2sm3340024wrq.78.2024.02.23.07.49.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Feb 2024 07:49:49 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH] vmw_balloon: change maintainership
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CACKNADUCcW-Mrkt14VeGHTKsZ9KHMt9h=hfcncmDGUCyVGZqaw@mail.gmail.com>
Date: Fri, 23 Feb 2024 17:49:37 +0200
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <400CBB6D-B5B6-4541-86DD-F1041B09A8F5@gmail.com>
References: <20240202182339.1725466-1-nadav.amit@gmail.com>
 <CACKNADUCcW-Mrkt14VeGHTKsZ9KHMt9h=hfcncmDGUCyVGZqaw@mail.gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3774.400.31)


> On Feb 5, 2024, at 9:04=E2=80=AFPM, Jerrin Shaji George =
<jerrin.shaji-george@broadcom.com> wrote:
>=20
> On Fri, Feb 2, 2024 at 10:24=E2=80=AFAM Nadav Amit =
<nadav.amit@gmail.com> wrote:
>>=20
>> Jerrin will be the new maintainer of the VMware balloon driver =
following
>> Broadcom's acquisition and Nadav's departure.
>>=20
>> Update accordingly:
>> 1. Update the maintainer name and email.
>> 2. Update the reviewer list to Broadcom's, which acquired VMware.
>> 3. Add .mailmap entries for Nadav.
>>=20
>> Cc: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
>> Signed-off-by: Nadav Amit <nadav.amit@gmail.com>
>=20
> Acked-by: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>

Greg, can you please apply it?


