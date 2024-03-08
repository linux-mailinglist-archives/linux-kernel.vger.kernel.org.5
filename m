Return-Path: <linux-kernel+bounces-97334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3C98768F2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECCBA1C217DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBB2199AB;
	Fri,  8 Mar 2024 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4EGrE0z"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0269E15D0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916903; cv=none; b=RNxo3mewL/8E/yDNXt9p8iCfqBDWmveXp1gbQNhgQ17jcX5RUaxxjEZve+tI/0ls712vogfRFhq2RGeWgi68COTxykrsgZktZx8ezqUnOeVQnIXsGyhh+3qOrdNTMR4GLF+yFYyaifz1sz3kH10JMXoE7gJxBXy2yN1+vJnf/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916903; c=relaxed/simple;
	bh=JMYqgG59sGbwE+vkh7XXAKjJLCjZIzJhDyaHDWjt1x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjAHLns8JVqa8QQfm+GMpVu/5TAR8Zf8fQis3Ymb3INohrZmn7jigOcxF/B4g7fO+AM9JbcFTPY7mUppevWzCVv5Mb4B82cYkycS7P3bs5ooA9qX1WlM+UF0w6BMXH8tCcRy6ePG4NCBJMvjvnOCQuoYQLNLscDdrPHoAz61Whs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4EGrE0z; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a45bdf6e9c2so281520966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 08:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709916900; x=1710521700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMYqgG59sGbwE+vkh7XXAKjJLCjZIzJhDyaHDWjt1x4=;
        b=D4EGrE0z8y2XtRd2sYGRHQyOUKrQScBG2lWpNB0xQTuiV8l+e+HSwwkI4e/e4cBtHX
         nDFloFtvsT6O8RfsjUVninGtVwDYAQ5BTDL/9K1Crc8DZ1TxWJUt3KUCdlLnHFcUhbvW
         RI3+mHvP8tQuLSYsIsldVCSTG9leSRgYkaYclTNj355tZaB5oP/SfnunUXDq0shu0hPQ
         g8oH6KjFbv3s/tCP5S1JTscWDkM7lTVKPfi/NMOv+hbUoTMc3QY880l1VPr+il/WtuN8
         3CBH+QLTolOnhjnMc5dQZ3AjwP8uuwvQLyhs68gIG05Wqkbm8Oq5styHrUxUDt1JM8jb
         2fuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709916900; x=1710521700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMYqgG59sGbwE+vkh7XXAKjJLCjZIzJhDyaHDWjt1x4=;
        b=vwSDrCOkcD5RcazAFMgBuH/XWFhRIGwEvmC94RW18BRSIib3HVkMFYwn5B2Z+r3FkO
         Q2JpDxdp4LCddt9y9Z4aY6A4BW89ZoQLQuIjyYXNC/b79NigFWCTwjy2Ub6S7gQofm4K
         B+F2Quc9t5J5BJLhPz89oNv4iFOH49t9iPa/x3XXkmQusx4r6QRVgoV4hDczPPgab3Fr
         9DM3AJqQqXKgPhyGSYmoiQh3cJwEwXhxW68N/8hSLbmbo1spy/TT2ByEEp4AKCYn8A2Q
         LZehqCShFQw1hBpTc25YIV5UAdbvbtSP634fxfZjFM9y7s4at/pmGmgFcRauJHQngP6g
         w9+g==
X-Forwarded-Encrypted: i=1; AJvYcCWTBy35oc9VDbo/vYTLcHFKmQYcsuJ14YY4UA3fEP5/NtOnBVS2V2Lz61g1oVWLMyZ/xQY2L7jRrOox7yHVzUx+AVbRITq+E4sZJ9vq
X-Gm-Message-State: AOJu0YzO9QDBnlUOuDL2TPVIoy6Sd1T3RW3FeNJuGzhFYtOXdgTuhTs9
	Y3vTz099DjtkPiwLvjx34CmDrZ7eqe2yQQIIDBmswjGJ1x+Y2LyDBoJV4V6YLC9IYg+qvq6ex2i
	GhdHZjOtWs7Uv6QchSIW1DxSHbug=
X-Google-Smtp-Source: AGHT+IHPaEuoZ2wYzkCSZZVGbiK7nhV2ABWMPa7IrCpsZRsuBbuDS2YhIlyjMQRH6lYqnIsQOfQRm9RxZldOFOYTnnc=
X-Received: by 2002:a17:907:cbc3:b0:a45:f1a6:8485 with SMTP id
 vk3-20020a170907cbc300b00a45f1a68485mr1794114ejc.44.1709916900338; Fri, 08
 Mar 2024 08:55:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308015435.100968-1-brookxu.cn@gmail.com> <20240308144208.GA9194@lst.de>
 <CADtkEefTzbYN4qEAgAXDTB-+HMxfENw2m+xcoxzy83YW-bGEhA@mail.gmail.com>
 <20240308163100.GA17078@lst.de> <CADtkEecyqONmjRorKOWzToH9y1SVXf3GXXvg_BHcFZ506mPWkA@mail.gmail.com>
 <ZetBP5YPUnJ2V4Kp@kbusch-mbp>
In-Reply-To: <ZetBP5YPUnJ2V4Kp@kbusch-mbp>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Sat, 9 Mar 2024 00:54:51 +0800
Message-ID: <CADtkEecN8nCmNAEm_p972J3mieffqrTk3z5xqC-rbrZakYMtLw@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: fix reconnection fail due to reserved tag allocation
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Keith Busch <kbusch@kernel.org> =E4=BA=8E2024=E5=B9=B43=E6=9C=889=E6=97=A5=
=E5=91=A8=E5=85=AD 00:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Mar 09, 2024 at 12:43:12AM +0800, =E8=AE=B8=E6=98=A5=E5=85=89 wro=
te:
> > Sorry for delay to reply, I found the patch have applied just about 10
> > minutes ago.
> > According what you plan to do, I think as-is maybe fine, But anyway if
> > need, I will
> > send another patch to cleanup, thanks.
>
> The next pull request will be late next week, so I'll back out the
> commit if you want to submit something else before then. Or you can just
> submit an incremental improvement against the current tree, and that's
> also fine.

Got, I will send V4 according to the suggestion of Christoph, thanks.

