Return-Path: <linux-kernel+bounces-52078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEBB8493E6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0876D2842B8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAFABE7D;
	Mon,  5 Feb 2024 06:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HULXs9zO"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6C9C122;
	Mon,  5 Feb 2024 06:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707114957; cv=none; b=QaHLITdHy6RPLc/IRk+DVH/8Y4hQca8aHOKp+75e9DT26eqliDtwME2lKxwW/15jRS0ZPyrZXd/3O+WBPrKM0PJMzsYqX/shPeZ6k+ajRH3PEfbwgtKgJhvoubn8Kamg4GPk8D7zsQzKEzs7OdDCijwqoKtR4C8uzZltwoMcpvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707114957; c=relaxed/simple;
	bh=37xwSkZGBn6kRog2s5/ht+B3QyJp9HGt4vOhAhCRMVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOZEZ3cV5DDV3cbKQNely2lNgnx7Gh8B5H7T/6HfMjClGKV7e4ezSqWnlmhYkuV1azM85z07OVIhNpFiFuv2sAC94gNvbsLd70fAX+EPaIK1/nO8w7zNVWdnnI2OrjsuUDf050SybFfmgOb5RerlY63utJILhkRN/At74WCOi3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HULXs9zO; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29041136f73so2705868a91.0;
        Sun, 04 Feb 2024 22:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707114955; x=1707719755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NN8HajuBsqniYL9tZVxAH9azcAWk91xgvO1JKAu/Q8A=;
        b=HULXs9zOafGVbi2Gi3rdvyVcqUyAIZc/ahLHVWnCn5VnxMDvYGHnv1lrrm56j1FI6m
         vdVN8vvrcmBcYyA31J88/xYCSX+ij7nFWczuevgBDXPxI58rSIh9HtozHkH2vcgHPgay
         oxmC9jTfOrw8M+NnRbW8rRuMUGeAN2JEV5em2vl7JvjJU5Sz5+rfBRMB2afIE5icnWQi
         EcoH0feI2fKIWUzzhbZ6gnMb4HB/wZn2gN7beflcBUM4NDUgHhdCHxXu2Exston32vP1
         h5AMNOyfOq06/dilrJrg0lJ6VyHU430EOK8UqAwW46b/poXmrWPrs1UVNkBFWgXmSRYJ
         s+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707114955; x=1707719755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NN8HajuBsqniYL9tZVxAH9azcAWk91xgvO1JKAu/Q8A=;
        b=dXClFUNmHLBM5zpFLI8cJJgcmqH5BFuNcUoauFm/DNsRspMr9C8KMq2KvnGgc0vZI1
         ycB0Z7xt75f95l+CdqI8OqTuyxc+7+NiDIw1NOSOMhlmts2xnFsEe1fdutqls4hTY7WY
         xvPFZe6s7Bj8uoqHkGm9Ia2ghlUBEH/ECjMVmUim+8ooKft3VT2SS10qmc2asBLsiA/3
         ACd5vimXIWvs75v1/0IVz5v8HC4iVjfhkrfhu11ynHCvMuX3pKMbZRY7m9Gmy/LBJ0+x
         YKdNOo41D4fuy8ZzuBWCKcXHkD5LG7pCS7z34a7kO3s/HaApVPi1zKlAMPVcmWGJkHP1
         /ysA==
X-Gm-Message-State: AOJu0YxkgTrWOusH52dk2SKgiNDsiL05b9ZmyOfa+NJME++5hPWxcFLd
	8g3bM1i/VNu8soz9mE1WyAMKBmloVBkzA6HnJzZMGov0cE/h80mi
X-Google-Smtp-Source: AGHT+IH3ifitTi233cP57EIXH903l0rFxGNIdwnk38cjcyDT/TxIqYvZ5Ab7dPU1MUBsldOKsXPUaQ==
X-Received: by 2002:a17:90b:1197:b0:296:416f:8341 with SMTP id gk23-20020a17090b119700b00296416f8341mr6668194pjb.38.1707114955454;
        Sun, 04 Feb 2024 22:35:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWdhBJdGNJodYPRJSiXeQN3cHmq5p0yJMtgtQSI6y+Xdq4O3tteapuaemDXUcH7Zn6SdIRcubl7g25xJDMGy7cm5kb9Nd2D09O5dhgtlxkgkjR850ph1jkMkXRgQYXxwErp21wXLuyjnbrS77X1BOtX5+ivONGU22ompT3Tk6noIRLXgJWvhDRpIK5Tt7gmPIK45m/OlcT4rUm3OWx2043/luHsG1XaYZE3cT/IdEIo1yFKtQIMgFN0dIC40YRdRhL6WGEdwGSnOEFbSLqUanpDEiA9nm6kREPUxCno3ynlZHPVgcIZ2vSrtXhZ1Z8YWuBXfl8/cJz58uFKhhPVxl5PIf/0huN1NfGEdXpe/3zLPf3FmR9edZFDBw5UASLKJrfxApkAl7a3lbimKtLkTV5w3Ct16xp5F+fsNmdIc/31hsiCDR+n+bPFJ3LZKNQupSO5A+eWRMiqcasu3RkdWs2AloNyUVV5krsQimdcxsgwc5ACNR7fs9Fv/IfuQE3fY2hMqOpMBXiNv2JMp9eWxore69dWU64ETkU0Xd9vzLCsYJ9fZmsBtf9cFCmc8qt/WP2qYWdDY1OkW2asOzz984jKBC4qusmWj9zb0ye6qAEKGTG79spa/R6wKaVWsxvs8Q==
Received: from dragon (144.34.186.27.16clouds.com. [144.34.186.27])
        by smtp.gmail.com with ESMTPSA id eu11-20020a17090af94b00b00296521d8ce9sm2525643pjb.0.2024.02.04.22.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 22:35:54 -0800 (PST)
Date: Mon, 5 Feb 2024 14:35:33 +0800
From: Shawn Guo <shawn.gsc@gmail.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com, rydberg@bitmath.org,
	linus.walleij@linaro.org, Jonathan.Cameron@huawei.com,
	u.kleine-koenig@pengutronix.de, heiko@sntech.de,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/4] ARM: dts: imx6sl-tolino-shine2hd: fix touchscreen
 rotation
Message-ID: <20240205063031.GC804317@dragon>
References: <20231223221213.774868-1-andreas@kemnade.info>
 <20231223221213.774868-5-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223221213.774868-5-andreas@kemnade.info>

On Sat, Dec 23, 2023 at 11:12:13PM +0100, Andreas Kemnade wrote:
> The display is in landscape orientation, but the touchscreen is in portrait
> orientation. Specify that properly in the devicetree.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied, thanks!

