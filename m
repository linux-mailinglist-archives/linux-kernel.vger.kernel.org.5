Return-Path: <linux-kernel+bounces-153810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8378F8AD393
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51D41C209FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE218154C01;
	Mon, 22 Apr 2024 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1l30bfB"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EC8154424
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 17:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713808552; cv=none; b=hB18Ijmllw8PDz32PTGX9zRqlpPi0iCYhP6Bwk9864vgcvPbvxkW/wCD1aM3w8QoevGk+Mgnh3s8x16GwXdHLkB3jhc7o5BwssK8yv+Y5yFq+23vnLRlDEqibwr2cyd3AONsq4IJq5+oQZro+4rwePiTVKqGAj5hM6KkQwagJiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713808552; c=relaxed/simple;
	bh=JSZu+JHGcp6O5rFJwB0+7gm/1fUE5JP/jTsLbXnt33Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=I7SvFRLBZLfuTf+Kab4j08NIkN7rlh19pUu3CapmdyygQ7hGR/Mo/AtR2NMMndWacCR9hrxHYHNJCRQkg0t2JOes7ga4RtmvdJY7F4QkgJk3/XIyvYdDQjlpRnRcRop3cxE7r5CrnbPQan1p67O3r+cGzPzqr0+LMwHPS/YObp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1l30bfB; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51ac949e641so459878e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713808549; x=1714413349; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yq4UihHHPf8X9fkzW8/5yOFWNRtWLeXNtouM4+vRomo=;
        b=S1l30bfB1LwVPYhwHgSmNcAw3JN5zaxR20q2pZbcuWonrd2Cf1Wk1cj+A4yGrjXLAr
         XrRgX00Qs71ak09gWp7Hmk0ecRUKw9JOkka0OfcrCV36WTT6jpNjBQxqgj6Glzk2wa6H
         WufSRre+R/xpH/7dtYq8I/8ZTxldPlb1w2+nyzALW/xD/BHwO4Vcb2H1j6PBlxnKlJxK
         SPzMjyQaKq3aHs6BcU5y4Regu4srqXO/Zxg+tg+wGncvA9kMkGHDfFgA25dIj1sTGC1N
         4HED/4EPrBHbSRtFxtFnBDwgjwNiyGA8/k7OhaN2a861MAAiv9cp8yZWJgYZWT7qNvwW
         oFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713808549; x=1714413349;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yq4UihHHPf8X9fkzW8/5yOFWNRtWLeXNtouM4+vRomo=;
        b=Tn+Xji6EE4b8GZER0ViDk2Bk7Za3q96W9Cx0DxpuxF5p1rwcOjaW/XPpBoLyrUMHD2
         YtYIlB5EJO4tRWCqDx61oKaty9ODKOMfrHAE24JCyrQIa9qWcnYihTIs4PvoaPo8i1uk
         vp5J4oErSn3DfokRUt/kNbl2eUzo6wf+yh65epq25gELf82P1ldxlcQU3t7arQnqjH3Q
         2W27QmKQtMi4g66fVj4Tk9+LZIsUTDclf2N6WQvxzMQG5XAYIuonE1hnLzfdlQddzd7L
         1jdiScWXo1bu3LdC1al3W2IL+dQodwVWmaH1EGhEcHqOPOtEEtKtqeOUZVP0Rx2d6xNC
         WTmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRhmEpM99rZb/Lwm37XqsbkTsJA/PEbYpAfAlPBcdV0b8GLs4lRs99mCahVZ/GbDuc6Oxlm/Txnngk+oimwRbu+YJEC7XnfrPeyTIH
X-Gm-Message-State: AOJu0Yx09XNoAXP0IQY9G1H368HVjkeSKQ6YDa7s2CA/RyT2gCzRaSVp
	godj2xIqKj2vCvPqux7OF65YKKB4O4A3MhEesfA9EwMU5t13UjGoF/lYBO5y
X-Google-Smtp-Source: AGHT+IFwMaFrfp2gvzap1J8QnviEFzpNnf0imbW5AdxuOzeoKDb25tpi5xxF8SxqM7m1vtyY0hbthQ==
X-Received: by 2002:ac2:4db9:0:b0:513:ec32:aa89 with SMTP id h25-20020ac24db9000000b00513ec32aa89mr6629628lfe.2.1713808548539;
        Mon, 22 Apr 2024 10:55:48 -0700 (PDT)
Received: from [192.168.0.104] (p57935690.dip0.t-ipconnect.de. [87.147.86.144])
        by smtp.gmail.com with ESMTPSA id x20-20020a1709060a5400b00a524b2ffed6sm6012023ejf.56.2024.04.22.10.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 10:55:48 -0700 (PDT)
Message-ID: <f82fffbf-a983-4ab4-897b-b5a810426f04@gmail.com>
Date: Mon, 22 Apr 2024 19:55:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: info@sang-engineering.com, wsa+renesas@sang-engineering.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [RFC] staging: ks7010: How to proceed with Spectec SDW-823 microSD
 driver
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Wolfram,

you contributed a driver ks7010 to the staging subsystem in 2016.

In the first commit description you stated that you have not been able 
to connect to a WPA-protected network. Did you manage to connect to a 
WPA-protected network at a later time? Have you done any tests with this 
hardware in the years up to today?

I am asking because I tried to find a test device to test it. That is 
difficult in 2024.

Do you think the driver can be removed or should it stay in the mainline 
kernel?

Thanks for your response.

Bye Philipp

