Return-Path: <linux-kernel+bounces-100598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC06879AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2849285C59
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CA91386AE;
	Tue, 12 Mar 2024 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UfIKav0p"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554CC1272A4;
	Tue, 12 Mar 2024 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710264611; cv=none; b=ctCal0cd4dsqZZeRJTE5Xn59AStKisrzZFJjdIxGIzagLJDKoWHyC4M9SY/6g3V0G18cj2NwSnr+GLxsD0UovcayGaWHEgzC1b/ZosArdpq2yTTi0E1X72OnBCLj+zXBfh+T2/AhyyGaYuRT+uFvQmRMscWj5KJgB2SBH7atE98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710264611; c=relaxed/simple;
	bh=c42YxN4jWTpl+KaVrC1vllZBtqWQkd/F8q+clCwOlgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQ/zethSg6wQt6vLK1vzz/Fxcc1zhvxECj7zWdpcUuGUSCQ93NltXB2Jb2Q6NHY8/HappL0LU31eR6KMkaHmBWPNSB6fhtpdzOqFBtCmUBlNKQQGzzvBvqulRjMbqZwf9t4BRp+KWhGwqvk20obLu4+6f+S4r9hk4KyehvzbObs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=UfIKav0p; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dd9568fc51so23102395ad.2;
        Tue, 12 Mar 2024 10:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710264609; x=1710869409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbJFRNdUX+AAn/XFov6URlQKxEMKvLoXoY0Vun2l91U=;
        b=UfIKav0pHTUINtYAzNM+YOOkKh99JLbjxbzPwgyzCfI+FxZhPI1xXKVK1UEmgAvKqc
         nsNjjW+2LvC7vYYJQR0aP3fCCZP1dTWaIVNqM2hEPwic+v+3RVhmWs1CHogFuBXBk7dM
         lUBR8j5/CAekRIyYP375NMFvWVXbauNrraO3gYcEQVZxn0FGgHw1axyeznethmGfzU5I
         15+SMKjqL742wNI76mRQkJxiYDbxFnyzkIeqtgSZrMn4f4U102xhlGwqreec8G+YgdWY
         1XQ78Jx5kB4uBiFsvPkGSus9pC97sWBCq4MPta8FO3bTEbcFWPXK1F1fOqnvnqnWlGZq
         T3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710264609; x=1710869409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbJFRNdUX+AAn/XFov6URlQKxEMKvLoXoY0Vun2l91U=;
        b=XWosnlZt3VQ3biN3n7PYZ2oCFacPPy4wuTx/bz8mLhYYIvZyETASVVEsxUaSbUeuvl
         1qB90eVUrcy3AGMg62ogLaM8l0J9kiPdFhmAUqQC0IxzkvXzNguNU9ikqxVf2gVCIsml
         PYSNzKn/cF4nRSLYq0iFL3dtVa4QD/+CE9YcTSaff4dJME6JTYgbsuqxz+VYxFbmpL2Q
         o1vmwjDjXaWppTc4mPEHB+d+BBO0evMJVKEb4Je/bK3U4JxS1aBvFuzwwi9PxGA/7o+M
         f+TRHZQIxpXlg+l8pVYNScZtoTEUMOv7yRlSueJsyNMIspYaWDDkd0c3jyHnbse2sIPL
         65XQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0vCb2dOr1PxZhABU0OsLfUlWIQpcWHZRRapGe0Iiw+qSQ0AsIFBeuGkMk9oPSrfhomEEMsa7hync+EtPcSdnCJtHPysSQMLlK12OcsQqSvmfp3Q1wGiVLvLhrrm0/KrF9EDpFxZrgzQ==
X-Gm-Message-State: AOJu0YzhdsEuC7zMBigztzt10NAMrxfeQT0xlrB1QQZBF8WYGuCYgTiK
	I+Rha2bAD9JaxhcCfNrEBLVHtMtpXeYaLEa8x743T4AYSVk2Nlgy+Iz1RiMepDLWvDeSQP79RPO
	/yy8PjfPpQ5zAFOqIVvQJ+GFCGf0=
X-Google-Smtp-Source: AGHT+IEHlHIqKOnI30N6kEVdQF0v/F2N8qpv8I46MIfHZh1wIGIrafjKKa9W6hn0s2Ee0QJLBfQkS+qfb6XgN0IPhOw=
X-Received: by 2002:a17:902:d491:b0:1dd:b728:b890 with SMTP id
 c17-20020a170902d49100b001ddb728b890mr3078233plg.18.1710264609530; Tue, 12
 Mar 2024 10:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com> <20240312-basic_dt-v1-3-7f11df3a0896@amlogic.com>
In-Reply-To: <20240312-basic_dt-v1-3-7f11df3a0896@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 12 Mar 2024 18:29:58 +0100
Message-ID: <CAFBinCAvT6-gfZQH--AVJAxiVM9bv5=agYzJ-u3NZUGFvp2vZA@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: add support for A4 based Amlogic BA400
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, 
	Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 10:19=E2=80=AFAM Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
[...]
> +               apb@fe000000 {
Node names need to be generic - since this is a bug it needs to be:
  bus@fe000000 {
Or if you want to make it clear how this bus is called then you can use:
  apb: bus@fe000000 {

The same comment applies to the amlogic-a5.dtsi patch (4/4).
And while here, I fully agree with Jerome: having a bit more details
would be great so we can judge on whether a common .dtsi makes sense.
For this it would be helpful to know how many IP blocks those two SoCs
have in common and how many are different.


Best regards,
Martin

