Return-Path: <linux-kernel+bounces-60858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F139F850A38
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5B328418E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1045C5EC;
	Sun, 11 Feb 2024 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1rHOomI"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7965381E;
	Sun, 11 Feb 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707667589; cv=none; b=RbKBaW8ynGuZlOLoZUXdh2HqoUp35mimLG6xMq8ei2QutXuTaxyNgxCEarOEA01MTfYpQCoXMSY99VAi9kd/F3yKWrv5Y6gtWg2c4zV/FW05JI9i19fv3FBl/N4+Fn5/uPRBKM7LYXJOihDAL+4bs1klKrnMnjoQiyE6OIDuTSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707667589; c=relaxed/simple;
	bh=J5v1lilPiTlSOrg+FnUKeXivswZYOjGz4FkxGbLee5I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=sxw1V9UwbxjVDn87U8GW2TYDMO3BK7CbqNUOW08Vd2hFoh6RWzvAazY1Px47B2lKMFo+NSgILntt21/sFV4y3CvmxTzJ13Jth+diqIqU3IVY74qJm3dGTWwGVSP/ulPSBAqnYYo/Qu7IHajzJRJIdtOL3aBITA6nozoFe/+E9Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1rHOomI; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so1282137a12.1;
        Sun, 11 Feb 2024 08:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707667587; x=1708272387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5v1lilPiTlSOrg+FnUKeXivswZYOjGz4FkxGbLee5I=;
        b=Q1rHOomIU47uJqGSc2lWGiRzzo3UEu7ry9zkkumwKviVaEXLfbnyBO5sMiY+Q6ls6s
         kEE4JvxBaBSiF5ukoshGRZgYir9nxgcmzSMjRYA+B+YIYajzJt+widGub2nPcuZXEi6w
         LTdTKUq07GxRQg/cuNKhCMieN+DZQqHPbcRJVAYJmS8jtIJ3QpUyPVGTcosjdTcG0wsU
         N7Q4F9edOJCSmA7IcD663BYE77mpSUu1W8C8kgUWD3CTJnCXS2Lq3WaC/XToR+hRvAq+
         E5uBGFApPeRauFLbglst1MQAUry5mc6yTMjV+/LXa5lq6rrP+NDf/d7Vr3ApsssHaBn6
         xrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707667587; x=1708272387;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J5v1lilPiTlSOrg+FnUKeXivswZYOjGz4FkxGbLee5I=;
        b=th4ea+VSGC7Z5W86+9OkBNLy/Dgj4jbVsPf/Un7lgouhRoUUXaNv19GWOe0C44zqlX
         SfKZbGnfxXnFlrOYWi/H9/J5VZ/5ahppurPjOC2L0RdIqAuTXAIdfmFrARbgD6qr+Dtd
         bF7+UJwi50YJlKIVKO1tw70xem7tdQDSSEYnx4STEjENTNNfOE2egzCUBh83YYoyLqzu
         8765wyEcZFmhWMVCqFQJpqPsz00kU+m8daUqgPTdSahkc+me2SML295bQ5iWIEcpdHtx
         UmtO9ySWHwpg2MS745ORhqOIpIHpYQvTgeGV2F18P9uIuO0bLwTtoMcn3TCvLHV3hAeN
         HO+g==
X-Forwarded-Encrypted: i=1; AJvYcCX6LFR/Tn7BYzeD5oUTdA8pfm606dLztNo9Cffkcqivn1Pz6awJkT0HhzMczLYTGfGIC26mY88RmnrQaAcUSuUT9wjoJNvHdeOEefBd76NxhseUtemOESz+RUdujsAHdMyh/zfbEhGFxVsbsXL3sw6CISyLW0mSz/jFnmz0PA+0sDFx
X-Gm-Message-State: AOJu0Yyp9e/vAoS50XpLYfPzT2/UpHYOvwoSzLeVNufz9uizD1Pcwejw
	yw4DGewsErwqy/qCSvtcFtaP5LFhesh2X4M6UK3Mj4SUuBBTqs32
X-Google-Smtp-Source: AGHT+IGBoWdAbZqysUxImCGwE8O25A18/b8hOtrELQdynZGxaAhikmARfR7WfEA96ofwjCVdk5AZMA==
X-Received: by 2002:a05:6a00:d71:b0:6e0:51d7:5805 with SMTP id n49-20020a056a000d7100b006e051d75805mr3198339pfv.1.1707667587477;
        Sun, 11 Feb 2024 08:06:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUz2Qzb9GZhStD6wRQZtPPb/PVsGvWS25k2TnMXC57Yd/y+wktpbP3LMphYxo59+hVppr5eTTSZ7m6S5kLoVPxYgpPpDHStG+2cH7UDBB5f3nqmmFqmdUALcVkaO2IIZFDbLK0WPm88xTPPG56BXLLui82BQVW+PhAq3tGLc5c5wsD1cWkeQnBcvaX5lSJYD9gda+gB/XzYuT5KOc5/XcfowUlKS7pk+45EXBqTxEyYNHcUwzafcma5D8EjH9WgIv2mtipDw8R/1VxvK1CczWei0EWDYZSfJ50qsLxjGRKouDHKJ4D0Z1h0hRVjfuWWCPl2ObPK9wMT0O65JLN5aOn/MXNe
Received: from [127.0.0.1] ([106.221.225.147])
        by smtp.gmail.com with ESMTPSA id m4-20020a62f204000000b006df50bbbaecsm3864390pfh.86.2024.02.11.08.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 08:06:27 -0800 (PST)
Date: Sun, 11 Feb 2024 21:36:18 +0530 (GMT+05:30)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: ricardo@marliere.net
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	shresthprasad7@gmail.com, skhan@linuxfoundation.org
Message-ID: <daa83658-8d78-4aa9-bd59-26b274534f57@gmail.com>
In-Reply-To: <qhnapkrcmqvpagzii46be362iyaelcbodo6vh7v3sem3ww5kpl@nw65w7gbyjij>
Subject: Re: [PATCH] Fix malformed table error in gadget-testing.rst
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <daa83658-8d78-4aa9-bd59-26b274534f57@gmail.com>

My bad, I should have checked beforehand. Thank you for your help.

Regards,
Shresth

