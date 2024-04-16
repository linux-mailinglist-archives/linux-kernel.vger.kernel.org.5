Return-Path: <linux-kernel+bounces-147243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3BB8A7174
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B19A1C21295
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7253CF7E;
	Tue, 16 Apr 2024 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RISmRxOx"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A5CFC1F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713285079; cv=none; b=fhxqipApbOVzGxyBuREGvGZq0MmfGv+MqITmQPD5CrT/3tbGYiGWnn61Ly2tr0RVcO8XdIDB8nlh13uwM6NW0DshPDXIwaB+/XKRE5Rg67V1OUKqBQkoGvgaj8CQdfskTOAw66aCcXcs7DUAuuq/yPqc8OKsiciDusXsnrTx/Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713285079; c=relaxed/simple;
	bh=D/TTuyRaftFb3LDRxju0Ljo4YVpxPz74LbyObKzjd2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsbNiZFAQtRYsbalfkR7RNIevYGfYvA+KTb/XKgbl+s2DerxhZLaxUi+LKmjQluvL0cQB1ET3BWzuZOMErEdMTTc16Hw7Kq14ZMqdvcppeBQlDg4JKzqneZ4CIMo6h6RQ9qukzbQjyDdpkFI1coIXyN4R0nkV4QQmbjvPT+Zi5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RISmRxOx; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso4502592276.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 09:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713285077; x=1713889877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9dToPYehH+g6V6v2hNgg16rhT+ANp2c0WokJKovgwYw=;
        b=RISmRxOxxCujjZUVVh+Y1LxtdOCbFGQ0XcqTDkqTUA/g4NlkP3FtOLUkTN+hgUU6iv
         47lHLsWh6oMDWtxMAZYWgxhAXdy0h47Mgc19NiYP1S+eCr96/ryeIbkzOrWpPBzeTxTo
         qWK5ZrMiOUbYEXakStWDcU3ZxJhprC4bDb9ZmQZNiRMpqHgZb606iW/TPWN0zS/R+Eb4
         GT7Do3B8uEPkOzAT6YvgfXGYgs0tMX4i1ECaGBO/N1il32Sf0cB48N4MwXC/SKQvbHqN
         ez7wI6pfUmwWlMQpKDTK9I+jDHlFFFtufygWJgORr3dK+FDhR7JAn97mrp+IJiR6w1Fs
         V6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713285077; x=1713889877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9dToPYehH+g6V6v2hNgg16rhT+ANp2c0WokJKovgwYw=;
        b=Ajhs12kuMP43LmsNT19AWc0V9BtfsisrD/gA0NwyHREEQTSa3xl5V0fhldldwXdEbq
         pRSxPsNU9E4+eq/1UFW0LSh39R60/8w+d40nROqfJ6Gl+iK54WuOLQV6+RDEHgqUaP/g
         gcvYWLGw1frznpTzVjA8SzL9LuaEv4U5OmKc//y6SMh5937J8tERr/Mwlsscdx+NU6QC
         SuHPJD8MaqAQ5JcXAtqiztEN7J7R4jTpvyvbidTHWLduLZ/QUS4l6AwpqsNJZ696Ke8y
         EsIDBNBDNSjrLvCQ60Iy5KiCDdcZ6UUKyncIXGURJpPgLI4GQKBIfXsJ+2KZ7yeJ/YMG
         /BaA==
X-Forwarded-Encrypted: i=1; AJvYcCWdrkvwywVRiUZFkcPvZEsTTF7aDIo2+PqR3nurrVgUWaudM63L+/REqac0sIPvQFj9SDwLGHujjtqnvU1z2msOuCeU6ROciA+p1+sp
X-Gm-Message-State: AOJu0YwFrsMH0YI3K+GR3JSus6sc0u2isgDe25RiyPl+V0KtEyHqbcs8
	WwqNe2TntH6c3XAmdTqdkgf7aXvfbIKR888WqsiVAqai7TwHgbEibP6mu6gj8Xldf7yN8HmE1E1
	iNcp9eUywYhIFqdO7DPHH0GswYv1PkiRCQvSFBunK0B1r5J8h
X-Google-Smtp-Source: AGHT+IGBjn7zuaQgCFJTrQ+1Nhcpwm06XCwoBwLu3ii+rK6PeQm5e0AS9rBhQvWI9xkE/yOff1MKshJ9e4elqmpnh6I=
X-Received: by 2002:a05:6902:14c:b0:dcc:eb38:199c with SMTP id
 p12-20020a056902014c00b00dcceb38199cmr11823917ybh.56.1713285076816; Tue, 16
 Apr 2024 09:31:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328095044.2926125-1-quic_sibis@quicinc.com> <20240328095044.2926125-4-quic_sibis@quicinc.com>
In-Reply-To: <20240328095044.2926125-4-quic_sibis@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 16 Apr 2024 19:31:06 +0300
Message-ID: <CAA8EJppg6MiRawsJ3A1_FKF_1cti6Jf0LQJOuTKx+Akhig9COQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] arm64: dts: qcom: x1e80100: Resize GIC Redistributor
 register region
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, andersson@kernel.org, 
	konrad.dybcio@linaro.org, jassisinghbrar@gmail.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com, conor+dt@kernel.org, 
	quic_gkohli@quicinc.com, quic_nkela@quicinc.com, quic_psodagud@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Mar 2024 at 11:53, Sibi Sankar <quic_sibis@quicinc.com> wrote:
>
> Resize the GICR register region as it currently seeps into the CPU Control
> Processor mailbox RX region.
>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

