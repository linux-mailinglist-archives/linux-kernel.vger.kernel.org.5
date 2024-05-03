Return-Path: <linux-kernel+bounces-167910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148C78BB0F4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 453DD1C2224D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106321553AC;
	Fri,  3 May 2024 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FSr2ZLmH"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A568E556
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753834; cv=none; b=Cdk9uSrPF7lp+RZOFe7TuQXJ9iSPzn0J9ugV6bML5e6Sg7ynsBbWWiQ7S91nhnwiJpgAybL3HXT3/XLu6VcSyyji16ipo7PhlSuj6EN4GOJyHaESahdDcPCPvmpwbEbZF1qFmaeXa7FyuhhO1OV/v6T2ltFbCJud1Gs7Me4F6Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753834; c=relaxed/simple;
	bh=WPVcs1TOpK/zIamQ+wtUWsaV9d+WzS0scr8FdFX/12Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLXq66kQS1xzpEcxo+B2EfjnTZ6YXq/3dianBIPyvtBYZyDH663xHZRymIhyIPDhYt0OnJKpmtkSZJWdYi0hqK2CFVP4x9YGW7VeVkR/fXbu46RTFWFwWFBK+5dltyIYfR1Vmf96L9AZHS1CMWJn/s20DDE3BckhYK9+X6hcA0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FSr2ZLmH; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e10b6e2bacso39790381fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 09:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714753831; x=1715358631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPVcs1TOpK/zIamQ+wtUWsaV9d+WzS0scr8FdFX/12Q=;
        b=FSr2ZLmH5u81pj8YyV/fFO6Yk3pWm8h06ua+SE9TTcWl2Nr9xrcYgGPf3GDrcURo5q
         zet2haQI/ccg/TGlbBo52xghSTT2l5+d8fc1D04teiQLgQ71RpmmuXAFrgRl9GVDZ3+/
         6VEssdQW/sYW1G0OeEqFJPyNi+QXpOuwd3NjR8cCIGpwfTWpxOeLBdMGs7Ya4+B6RbyN
         qIjVU5LcG7n2eC4YR2/c/9mfmq1+n6ltIS5D0iMKqqhZfNEcmQRKwg5Uwy0KIyDDJwqX
         cxqg2fMNm6QQy8qOpwjMrvTF39zBBpxbwvWKlS6Dqyj/86CJmhZb5B0HtmLGRamowh+P
         P+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714753831; x=1715358631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPVcs1TOpK/zIamQ+wtUWsaV9d+WzS0scr8FdFX/12Q=;
        b=IHw6b53NQuDhrqPi8Gj3be8lYFO0FthaqXbpaWbFAhJscam2cx6ZLXZnKmEjR3Mhpq
         bS0UpKWTTWOU7bkMqR2BG9QX0UmHpTPnEhwnd8jSTrmQMcsFBy9QlP81ocf/DgojSLJU
         IIfS9W4pCV8qgxpZr7DizU43sQPt3hlV+yM/SVeyg9EEkFkkO4jVZyrzVDfIjX+oJifg
         tSFRm+QHoECrqulFzx+10XS4LPS3guVw9PsF2urat6Tqfp2EmPvfiBtVCnt3rYfBYnx0
         Wfgequ+U7vjPrPXlNsjVRMzh/qxvR/lWH2xHA4xXo8FMVLeHYMnaOmXIA1lKHEu3iZVO
         cRpA==
X-Forwarded-Encrypted: i=1; AJvYcCVb3E/ENRIJBty4ZjgOEi9R6KAIxu73SM6KglbwjqEwlLFe1Ba0wDJqxab9Zv9edBfrmayTewAMTjN0qhwB/fcSwcm6d5arGuBQWhBA
X-Gm-Message-State: AOJu0YwDLCq8QDXGoihPXZa40oNk/w0/nhf40SUa4ygH0Q4BGH8zWvy5
	A8HQ+ClCM5/8mH7c9QRWSWjjcGjj+DMgO+w8LlzSD8uPsRgzo26PuV86JqaU9vwJOHknpqkA9w1
	tT5DQ9Q/IS4+PHsGtheEINudiDlIMnR9ryHXm8Q==
X-Google-Smtp-Source: AGHT+IGE7xxu21b/33CNpShSktw1p7c14hONSdRe5GLkslIarmkQXZLYgc3VeAksgpSpBEPHVsKNhmZwLeEcUDNOhGw=
X-Received: by 2002:a2e:9310:0:b0:2e2:72a7:843c with SMTP id
 e16-20020a2e9310000000b002e272a7843cmr1041621ljh.36.1714753831332; Fri, 03
 May 2024 09:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
 <20240502-dev-charlie-support_thead_vector_6_9-v5-15-d1b5c013a966@rivosinc.com>
In-Reply-To: <20240502-dev-charlie-support_thead_vector_6_9-v5-15-d1b5c013a966@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 3 May 2024 09:29:55 -0700
Message-ID: <CALs-HssJRSZjuDQjeDiSRYCyEnUDBKQRNCsEVPmLrCKfz_H4Ug@mail.gmail.com>
Subject: Re: [PATCH v5 15/17] riscv: hwprobe: Document thead vendor extensions
 and xtheadvector extension
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Conor Dooley <conor.dooley@microchip.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 9:47=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
>
> Document support for thead vendor extensions using the key
> RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 and xtheadvector extension using
> the key RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>

