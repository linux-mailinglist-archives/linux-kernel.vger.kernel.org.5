Return-Path: <linux-kernel+bounces-42296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 069BB83FF40
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC8C283541
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D5D4F1EC;
	Mon, 29 Jan 2024 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjwDujoo"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07674EB3D;
	Mon, 29 Jan 2024 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706514636; cv=none; b=SinqM4W0mqblkMNATiHO8uCx56/ZO9btCYfp9kFQyd/CJOKFQchfN2wKsBhKQ0bt9/pnAm0V6bAdWc8GhmwBXhPMm2BdixRaNGKcJCK8V/B74TJ3xkZAYs4A7REBiDYwDaLB6L4VxZqmZh42Lb0IE9ayULErW/e52i9uOfUWngg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706514636; c=relaxed/simple;
	bh=daBtVwb/lXqjAG7knocO2q2VJO0kTxb3gqnLhCRYuBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dvAHFGuI7mj249Csxmyew9vCB/XIgURscTmplowb7Gv+aNixGym5UPrQ5ib4xDEx17pqU2/Ixq0KbKmXW62C9X18gaI6yzOU5ZEVZC2FTdhrhGBOlcVvmfQKsQujEx5ylsqfKpgDGirl2FB6IMX4S8bZC8Kwb/AHGu7z4m0vSyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjwDujoo; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso770667a12.0;
        Sun, 28 Jan 2024 23:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706514634; x=1707119434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daBtVwb/lXqjAG7knocO2q2VJO0kTxb3gqnLhCRYuBY=;
        b=gjwDujooSxKr1WlOtJT9HmgsnA6vLRZc9s4Yr4TdvZErj5F4b8M3+rwilqoPcXKMVn
         MAblr4KzIhe0yrDn83Er5Ejv5W1JO/uoWNE12r0eMxfF+cK9r8eRXZTQ0Ai1YQed4ElF
         h0RigkrrK1vPB45//+ooRzRLXFByMyFNeebWfv2cR4WHdq+SZKVzSlrlyScq4fiXKWq9
         YSQeh/Ob2xJzHywDbLuoqwBlXkTMQqRChDh9E4YGJeNexrEzRm5xEt3Wj3XZf97yTKSY
         Uscm/FFxv9GoFovOt/J42FRYWvYB+MuhPl6s9V/4V7ChvTzCMA2vUgh9j9emSlW85zsM
         Ts/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706514634; x=1707119434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daBtVwb/lXqjAG7knocO2q2VJO0kTxb3gqnLhCRYuBY=;
        b=Beo2g30qHfXMTpx90cyO+zGWrPDQPDPpPdQOesRB7TTED85Zi4PRWUi7x7wQEk3U3W
         X6iee0/GeiOiLvyPGsRPT+1N+GuXkorqkfKzluCHaKhMntJTpCcHBzrnbY9bsLGX/Jyg
         s78Cx6rHeVcM45FbXR2rRlzcgJU/nJJYWB20R2xHaU5hTRYBJFCEjc/7A2EWwEoEMDzs
         SW6QSVOf85LbTDKv5bBOYhOR2ytIPY/wyhzpbr5jSnUQThoCkP10+2UkF8Ksl4uAfWVG
         kUeR9eQ2z/0yzZb3a/I6BY2Tx0fMCNnti70RlR3MrUFM4VdePSatnoRKwrh2KAHsyiG+
         JU3Q==
X-Gm-Message-State: AOJu0YwyzmRrcJpRXc9MajhaNjx+9DMA8R9KDz+VLQLunN3OPWjPlwy4
	A0wNS0CFJpaYufSVkE33hDIfH57S5D7ol8SfdYe5c96E8ozA2oQc
X-Google-Smtp-Source: AGHT+IF7fEYIei+OVQWtVITm5s1kpndgqSHGPRXXSGXQJ+77ZRujKNPYEaQFdrEZqcFm4BZ+b9UnjQ==
X-Received: by 2002:a05:6a20:2d0a:b0:19c:ad6b:e1c2 with SMTP id g10-20020a056a202d0a00b0019cad6be1c2mr750080pzl.12.1706514633901;
        Sun, 28 Jan 2024 23:50:33 -0800 (PST)
Received: from kohshi54-ThinkCentre-M715q.. ([2404:7a80:c880:6500:a374:2c9:8d38:9a2d])
        by smtp.gmail.com with ESMTPSA id kh7-20020a170903064700b001d721ee41c6sm4737820plb.232.2024.01.28.23.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 23:50:33 -0800 (PST)
From: Kohshi Yamaguchi <kohshi54.yam@gmail.com>
To: rdunlap@infradead.org
Cc: corbet@lwn.net,
	gregkh@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] doc: Fix malformed table in gadget-testing.rst
Date: Mon, 29 Jan 2024 16:50:30 +0900
Message-Id: <20240129075030.52625-1-kohshi54.yam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d3bc8995-b0bc-4d9e-b811-fccdbaf426c5@infradead.org>
References: <d3bc8995-b0bc-4d9e-b811-fccdbaf426c5@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Randy,

Thank you for reviewing my patch and pointing out the similar change you posted.
I appreciate your feedback.

Best regards,
--
Kohshi Yamaguchi


