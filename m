Return-Path: <linux-kernel+bounces-96698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568CE87602E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861361C22952
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7C2524A8;
	Fri,  8 Mar 2024 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clPG7A85"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408BE52F8D;
	Fri,  8 Mar 2024 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887887; cv=none; b=fwOhUPbBgkJqsTrSqDjrlYUN5koO9/BfGS7QbyUPIoxP+ENcjEYWy0c/VUprmIgxhme5BzukR1sxqC3bdmZlr5bVr1Uw5Adl7/M8XKcLU251BScPkouF88+UU8yjALyZ2+PA1ey3oEQSlbXwp+pPse92OXhgldqaJAfyu+ELq9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887887; c=relaxed/simple;
	bh=30gKOMQXRISTS9Rz6SFTXrMur3HE/QvKivjdfrp3tZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igW533SzuQ2tdyCY4OxkrFjmpE33n4Ed5jUVMMV2spGkyBN9BQBFjBmq12r6gsZSoHtKk6yovMY1Aw4AtTLX4+QarNBjvY8D8Dn6cI+cH53dA6Xx7tz22OjQr/RpsGCOu7VvW23VWz0GLpgDunwV/++kXDheutD1Qr8JsH2LvhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clPG7A85; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5dca1efad59so1473085a12.2;
        Fri, 08 Mar 2024 00:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709887884; x=1710492684; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=30gKOMQXRISTS9Rz6SFTXrMur3HE/QvKivjdfrp3tZs=;
        b=clPG7A85eJcy4y5cXrrx43sRMyjC0At5IsKSfs4ne8+QAmnnl+QhmnOsRRxisVY0Dz
         MWNyJoepMPmSoFUenUIy/JEaTqIfrYHdLNTqoAo8ta688Nj0W8C1JomOVIxHnk4CScOv
         6mLeC1oJYEBjrGXHqfhO3lZ3Vam44yAaG+bz4sKxHo2auhd5A+kA7yoiBrbwCjuOPR+p
         nFTtz7W12HIYJ92nEc72CvFbIfGvn0kpUiZ8w7qfaT2QxOhJcas8YdS/a2N81pUj/14H
         Eg+PparQYh+G5eFdrqFfc/G8JxO+fjm5V5AE35KhomdkYDiAhI4WdkISszS7G8D0bzH6
         vdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709887884; x=1710492684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30gKOMQXRISTS9Rz6SFTXrMur3HE/QvKivjdfrp3tZs=;
        b=S/lWAasRPlNq4Wu97mQvaLLG9kBe46k0hCU/41WnHaIkZt5+jkbF+i7Ol7s2/QiBL+
         /6sIc5TMgYWrZW3cun+UIUeDnNP7A22AM+jSALEv1WAuHgPe2kpwMKWN2xetq+OCZk3I
         /vrsX8CeXqIYWOl7dGaS1ditcOxgUDGpfd0f2LAWYubXHor03KDB7nIDCL51Yfs9CZpl
         0muf+7lqzRkovyDgjWiX0toyra1WxvzGF2RsqGcaYWL1qN2SVocJmb0DekWcL5n56azY
         UtvvaDpe+h+XrL9Ix03RyUlBqtkB1GHUieKB/0So51pSmISPjfbFisdEvwoZAxraSS/g
         R9og==
X-Forwarded-Encrypted: i=1; AJvYcCVHXZbZF00C4wNYY867yiIf7wsJO2F/2E4k6swfJz7AXEkoCj5CPBpPoFnfrgqugKUW7eMPkiEIEKhtnovSlkrznIgTQ2ZkWiWYxXYog34oXp+a0FXA52uDDA0Fs5JLaE+rNCM77X0OGq9FIv96fw4ipWdQNd+BGXgiDpvmWEIKbsVz0bG6dwg=
X-Gm-Message-State: AOJu0YwbqJb/+HMt5CI38Fr8xavcYnmrxuD5/3Fp3mFGtseiVthPOeMF
	lbf/BBzuO+xa1ckvYWh14jF0soW6/zJvLD4+y2LG3y2siNS9F5INz72DONB7hrimf34e9KvU5q3
	yetEywZiXx/3mpc8PKFN1zuPjhFY=
X-Google-Smtp-Source: AGHT+IEbARtx7ZIcsyIJ9GwCELFfzLvsfznSWPCzaP85nB1NZ4VYYGj0yTJcS4PixiAQ0aktDfOesvmWocP3owj/Ubk=
X-Received: by 2002:a05:6a20:160a:b0:1a1:4fce:8eeb with SMTP id
 l10-20020a056a20160a00b001a14fce8eebmr10518036pzj.8.1709887884501; Fri, 08
 Mar 2024 00:51:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0b032929-f525-4b2e-a176-1a447cf0fa7f@gmail.com> <20240307032620.94310-1-amadeus@jmu.edu.cn>
In-Reply-To: <20240307032620.94310-1-amadeus@jmu.edu.cn>
From: Robert Marko <robimarko@gmail.com>
Date: Fri, 8 Mar 2024 09:51:12 +0100
Message-ID: <CAOX2RU4BOc6SPbYygq=iMR5EmCvHFtkiBjxXGm7pLDgPY_-7UA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: ipq6018: add 1.2GHz CPU Frequency
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: andersson@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 04:26, Chukun Pan <amadeus@jmu.edu.cn> wrote:
>
> Hi, Robert
> > Can I ask the source of this voltage level?
> > Because, its not present in the downstream QCA tree at all.
>
> This voltage level is what I guessed through the mhz tool.
> The downstream QCA tree uses 0.8625v voltage corresponding
> to 1.32GHz, which does not need to be so high.

Well, I am not so sure that it will work for every piece of silicon out there.
In OpenWrt we got bit by fixed voltages on IPQ8074 and had to move to the
downstream CPR driver as the variations between the same family are quite big.

Regards,
Robert
>
> Thanks,
> Chukun
>
> --
> 2.25.1
>

