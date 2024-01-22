Return-Path: <linux-kernel+bounces-34158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBFC8374A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9231F24FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976A047A6C;
	Mon, 22 Jan 2024 20:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TSxyO73Q"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A095B47A58
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956817; cv=none; b=IbJWKieBCcpERHa0fwG2XUEVYNRfDQP2b0snvP/fphalfIdsgLe33IKsoRDCOJoCqX8NSAEHQBbrQm7c/GaloLzhzbQZ0UN7oUGaWgUA00koAdw3WaM+vkguP49Mh8sG0dm//midgMY6LjrcT8/Tkw/WZNZxrBwpLKvwSXF4viQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956817; c=relaxed/simple;
	bh=pQZ/0oJYyx8RBYUqEkKQbxBgGICsFMfIGmf7BMkDDnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CXLzlYVSFM9P4FZ7IYS58HjhcpLXR91qeqxn8P01SAe/aP7h01qTyJLrW5z4ZoVs9zgsWqMwkIH3unPft4fZQsgUunyCQArdB+HJI7Cfm9Tgcy6MnFrRdbP8TS8KEiRlc1qPyPD9SOBcsKmoTbImSWA2ikM3R7N1vvz5ssq/uoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TSxyO73Q; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-59927972125so1870457eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705956815; x=1706561615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHLpdc+s1DN3hjZ1+Wn70z3BiqgmQibATYm0MQ7joBo=;
        b=TSxyO73QFgkNr/O5Ie6a+Vo14DtBPzY1FgYc0Q61r259bTdjX10ZFDQ8bJcOkYoRZx
         AyeVPzUy4eeOm6fevtDySSMcM0Zsnhw9DuMkc2s31kPG2rMqEVrb42UVXVxEpN2LP83x
         SxgWWKSNQfY0L/BndOpzGSQX1em3l6YRXlmcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705956815; x=1706561615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHLpdc+s1DN3hjZ1+Wn70z3BiqgmQibATYm0MQ7joBo=;
        b=H/Z13eI0j8YBN1zW1rt/gIPlnngKB5xrGrHUkaLrbhlNvp5tXJsKiFxtSGFZwEYPbi
         RyQYDT3XN/pI9+zyyCOBExcd/jD+SVgliP4GO3cVsH92Z2aU8YgSqsq4VCp4+UEv9qxK
         gvNsJ6D5vyAQa/kZMOuAtAu04asPtj4Mn8cmqm/Ql7q+jpoapC2MoI0WcowG3r/evLYu
         ttu+nFzEesIpkQAsjUEH7se1Mk85Dq2SIieNirRvbVR+ZMb+CuXWmfBEo04NnpcR+bFl
         MPW/9GEdPpycHSiiANcldhopQnysQrzlzdoTEvTfa1g7+0ovM6WBXsZGGS+k75ziH0mg
         nYlg==
X-Gm-Message-State: AOJu0Yx9BcgAqmKJ4eWMZ1NCrwqF1I5Bm8hS6KlgXI24yKiwL3N0ONAC
	uR3+XNLyjTAG1ZIfShiOIV8fT+dvJb5ScV8qL+hd/lUwkOG4SRlZfWJ0+1604A==
X-Google-Smtp-Source: AGHT+IG/TsXyZtkk1k/hwUr+fNS9q+PRnByIwu5fpMOy5PEaaP0vT1BkK07OjchmNIFEHImbtVdfaA==
X-Received: by 2002:a05:6358:3a1c:b0:175:c7bb:5bbb with SMTP id g28-20020a0563583a1c00b00175c7bb5bbbmr2203322rwe.42.1705956815668;
        Mon, 22 Jan 2024 12:53:35 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k31-20020a634b5f000000b005cfb2c44a3esm6884300pgl.3.2024.01.22.12.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 12:53:34 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] Fix error handling in begin_new_exec
Date: Mon, 22 Jan 2024 12:53:03 -0800
Message-Id: <170595678126.1295697.13621931577825110324.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <AS8P193MB128517ADB5EFF29E04389EDAE4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
References: <AM8PR10MB47081071E64EAAB343196D5AE4399@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM> <AS8P193MB1285304CE97348D62021C878E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM> <AS8P193MB128517ADB5EFF29E04389EDAE4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 22 Jan 2024 19:34:21 +0100, Bernd Edlinger wrote:
> If get_unused_fd_flags() fails, the error handling is incomplete
> because bprm->cred is already set to NULL, and therefore
> free_bprm will not unlock the cred_guard_mutex.
> Note there are two error conditions which end up here,
> one before and one after bprm->cred is cleared.
> 
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] Fix error handling in begin_new_exec
      https://git.kernel.org/kees/c/84c39ec57d40

Take care,

-- 
Kees Cook


