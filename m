Return-Path: <linux-kernel+bounces-128558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7C6895C6C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C0B4B2222F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F29A15B96D;
	Tue,  2 Apr 2024 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eRUKtcdW"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48E415B572
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 19:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085945; cv=none; b=i4F0lyGvPuYIGl6a5d96o9P48CJo24UmnrjbrqBim1cJTBflDuiYJ6B7Y1S37fnGTD3pwMNS0vNHQgJ6U4A2eCrZeRWzZtTa/pAAV4TWeYjaVwygnrPKj9a0Z9sVJLr/17phdM4ydj786U9hFjelFh5tUYxf5V994Yk1B5DIdtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085945; c=relaxed/simple;
	bh=nuVk2rrPA+78ak46RlwfYXTFyzdDDE2jrqhHVoV+Z1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rYLXGfum8yjisYoIVYEw/72WHBCB8+H2jJNcTQDxdXERcuIXZNM51DGMUz9oytqlVOzSPPPIn8b6hQncgZuH67iOKFxZLOgRigXkM10SXR+uqhx+y7Mcknetps+jsnWrUhYr2ghV7Y+nJ9ltZ57GGl+XyWr/5Au2ceiTitO+FAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eRUKtcdW; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dd02fb9a31cso4837373276.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 12:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712085943; x=1712690743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wt5s0i3Bf+a37LH9mW+EUzfbFaTvXfHBxqu8Vrd66jY=;
        b=eRUKtcdWpe86riGzbCKgEMCvzWTToENpdJAPyKlfdEsr5PvWRL3utQ9r8TpBC7focN
         j07zITPYqxGQRBL+l1Y4LFCUWZRVsv3h7iiDAqzKB2hKYt7EpYJfvDT2P4HFBl8zOkdj
         V5AqF6oJ90MXGqdSsA2AAvv3q3yVeaY/vMkgcFUCUtX24PYWVSI4uXanASX1+EK/eipd
         CKPiHMPgfO/+7VRw3s483x0njYoF4HaFXv4Qc/9SDT7YxBViSeyaAvK1HmwYT8zdxhKD
         lX1KmDoIn3YEpBXpV/vqrOhV7jdbRtgjc1KvprkdxSwMzUiejJChi51BC8kFEcwylNww
         fMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712085943; x=1712690743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wt5s0i3Bf+a37LH9mW+EUzfbFaTvXfHBxqu8Vrd66jY=;
        b=WX87UoCosxvmFhUMhD8ZQdKHA3Wo7FCE0EW4DJkxiMadv8ku643nVeZUvkrBwjHly+
         YU3MJa/1p6JG/yoDqx7aXytAf17JDTeBplHLKGbQcdSolLUYeWkIXNXuB6CzcBZSlR+f
         pH/t9RJH9ZB8mVlwOOXgP03mu9hce9xL2sICLKWygE7NeI0H02oHjlwGbzOYKoKKRnES
         jPojVVoacQAAkHox0XfxkZ8kLWLs5VCNU+GycFAJGA0dWagZWJTC/QO/ANfQnRVk5Tbb
         f439OhxLZn+DdTpJpqwlHhxR2cEmMoXu9KHG15l3mi3klDM2JxW5uNoQbL0XVuu5zPY9
         sXZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUynEyQsbA6OitGsEjxGlAG2HsGs5BTDGlRaEOiq+J01T+Unb7c7yQ69MUXhBu/LQFSoeE4y1PhwqutE+HrEeCzwhFJ94stnvsf6wFl
X-Gm-Message-State: AOJu0Yy94KDY0z5gByokjJYYtQ0AWdVJKptXGgVT7+1Y2HvjcI4dOQeM
	nvaMqrXDvvYZanahGHsfftcavooLLBoksBErKKz134Ml8h04CI0cQDl5RitUskmszTxA2z72/xI
	FtEyriacLbnYp+Y5FvKIJfLMUpEZFgMZvZ+5cXw==
X-Google-Smtp-Source: AGHT+IF0NCPeZnC/FxDzoqpqrxq4T4tmylOUOl34+HGr8LAiprE09JWVEjadMflb9rYYLe9n6G9XkDK88BIiin+WUmw=
X-Received: by 2002:a25:b90d:0:b0:dd1:2f58:292b with SMTP id
 x13-20020a25b90d000000b00dd12f58292bmr10593508ybj.9.1712085942918; Tue, 02
 Apr 2024 12:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129-ufs-core-reset-fix-v1-0-7ac628aa735f@linaro.org>
 <20240129-ufs-core-reset-fix-v1-3-7ac628aa735f@linaro.org>
 <CAA8EJpphzwoCaetGfnM8dE478ic1-BMqXKA3XVLeC9j5BBu3SA@mail.gmail.com>
 <20240130065550.GF32821@thinkpad> <CAA8EJpqZYp0C8rT8E=LoVo9fispLNhBn8CEgx1-iMqN_2MQXfg@mail.gmail.com>
 <g4a6gl47kfjx47ww36qnwp7zgvbd5gi5r7d26ibitfrybaa3l4@gvnz2mhsdf4s>
In-Reply-To: <g4a6gl47kfjx47ww36qnwp7zgvbd5gi5r7d26ibitfrybaa3l4@gvnz2mhsdf4s>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Apr 2024 22:25:32 +0300
Message-ID: <CAA8EJppOPrSfD=VkHm8M0P07=mN_BikT=cGvLe6UFL3OpKVWzA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: msm8996: Add missing UFS host
 controller reset
To: Bjorn Andersson <andersson@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Gross <agross@kernel.org>, Andy Gross <andy.gross@linaro.org>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 20:35, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Fri, Feb 09, 2024 at 10:16:25PM +0200, Dmitry Baryshkov wrote:
> > On Tue, 30 Jan 2024 at 08:55, Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Mon, Jan 29, 2024 at 11:44:15AM +0200, Dmitry Baryshkov wrote:
> > > > On Mon, 29 Jan 2024 at 09:55, Manivannan Sadhasivam
> > > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > >
> > > > > UFS host controller reset is required for the drivers to properly reset the
> > > > > controller. Hence, add it.
> > > > >
> > > > > Fixes: 57fc67ef0d35 ("arm64: dts: qcom: msm8996: Add ufs related nodes")
> > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > >
> > > > I think I had issues previously when I attempted to reset the
> > > > controller, but it might be because of the incomplete clocks
> > > > programming. Let met check whether it works first.
> > > >
> > >
> > > Sure. Please let me know.
> >
> > With the clocking fixes in place (I'll send them in a few minutes) and
> > with this patch the UFS breaks in the following way:
> >
>
> Was this further reviewed/investigated? What would you like me to do
> with this patch?

I'd say, hold until we can understand what is going on.

Mani, If you have any ideas what can be causing the issue, I'm open to
testing any ideas or any patches from your side.
Judging that the UFS breaks after toggling the reset, we might be
missing some setup steps.



-- 
With best wishes
Dmitry

