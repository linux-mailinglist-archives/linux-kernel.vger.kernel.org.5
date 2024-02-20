Return-Path: <linux-kernel+bounces-73016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3F885BC24
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C4F2B233C2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DCB69D1C;
	Tue, 20 Feb 2024 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="lwMcGTpm"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1ED69D1A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432138; cv=none; b=tEDkc7P7/iZoaK563RR243nX+/lDMfmvgNmSdMjXoZ9qik+1IUBLVkcatLeJZ0o/qjLxc7XG5gH3wPWO+VzhvopxtEcl0/EGql65EYPNqdt3//psvQMQp/jLLCGikNd5ulIPNPK89PbE7BpM9YxOzej2SaX4eGTGn4YpTtDoPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432138; c=relaxed/simple;
	bh=Lqd4WYUnccIBIqbzl7+NkpSoALyemojxRPYdhyqxBFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djrEFAg/3Yx51iFb+vLRcVcgwfDkueS9qS7RV/3HsiaYPjR8GhJsXlgb0dcBpJVtHs7HHJUon+mTRszRzVEFHqtv7SpxD6ZJlE1oOXKwEHBFelJC9/OMIOik9MnreCKhw1C+1dhBtIjLYTq3FYAarnazECKy+h4XWNy0KJupqms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=lwMcGTpm; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 598B43F642
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708432134;
	bh=Lqd4WYUnccIBIqbzl7+NkpSoALyemojxRPYdhyqxBFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=lwMcGTpmZefP9hlv8nzN/op01oN8AmR3LbENt7vhhI82aLOrLACKTb63Sr4XJ0t6g
	 dhUrb1KTX5ZvedUP8gYEvGBdr7GR5gsfEqwYimjq/UdfJColzb3CKzezjclqPYCtUz
	 gP5nNSE032HjScY2XP86CSG/lNm/7rMmxp2iDa6BuStxac+LJ3wd4JQkZodE5anj0m
	 cxmbtu843Zbbs5wGOg4LCSbverZ/W5Mr9PXQnbfdjwO2AcqC43TjqIiRTBbAZ8KQF6
	 gWJ2BfBzsddwn+rFP2EHDIOwsvHPpwinl6oWmVmiPI2maPaaOOrwQTPZBUtrSeXsun
	 iTPTbsHTh59VQ==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5dbddee3694so3400409a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:28:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708432133; x=1709036933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lqd4WYUnccIBIqbzl7+NkpSoALyemojxRPYdhyqxBFk=;
        b=h/6vgb1gzTluAGE8Cg8WWqOK279u+LHh3LGHglFDMQQo6cXLNfvavnBLGtdh7r0ID1
         Ue/XzbvJoG47kDwpom1lE0j4dax/t3p8B4eSL5WGUyfimMRsAOjnqTsojQiPmoRcoT1b
         shjcADJhY3nk9G+ba6UYH8zDdTfVkaEsBnDTvRyLZ9gGUaFdfzhSKnCRQyrQC4DxrUY/
         x064NUVOlL33sKi61T86M0L7KHyV4cdLLRhRRQd+3dAP96dkZjcIKpv/fD0uHcDumPfH
         RIl0BspI5J2jU9PQufyjRXWrQVWc3oqgjhSI+t3TuS1yNtCDbOI5W7lNuTBRYvgbHfu+
         vVug==
X-Forwarded-Encrypted: i=1; AJvYcCWiRlDGNPK48wioh90t7udaIiVpY2CW7MJkmVd/1MMmibGvLEMgkhVz2ScPPT9abdBfWcvrICnvjeTLEeYdQePwRX2OaFTO8/Sb4EBV
X-Gm-Message-State: AOJu0YwFsyYXBEHJt/1XqJGe/VvvU9qEh1ilI4bLIDKTYGVH+2jUOMc0
	ZjNv4PfGf4Qs1HHvZYUbsteDbpI6Xtx5GVzg0qcmeiwOXOTaA7wloQpGe5Am64QWJhzPk339EYI
	5UmutTk47rcWSNS71OSQFVB98tNZoT45eug1R+EYhd4x6kohvPDlTqJrw3h+NABhlTlFYtU9h6V
	RNQQ==
X-Received: by 2002:a05:6a21:3a85:b0:19e:a9c2:e0cb with SMTP id zv5-20020a056a213a8500b0019ea9c2e0cbmr22090882pzb.25.1708432133016;
        Tue, 20 Feb 2024 04:28:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE97B84Uq2UpG+abN/I+MwlHDTBfcdhI2z2qjsMLJLhpJVYV244lzq4DKO4QzS2xoZVv0hL4w==
X-Received: by 2002:a05:6a21:3a85:b0:19e:a9c2:e0cb with SMTP id zv5-20020a056a213a8500b0019ea9c2e0cbmr22090858pzb.25.1708432132712;
        Tue, 20 Feb 2024 04:28:52 -0800 (PST)
Received: from fenrir.. ([179.108.23.66])
        by smtp.gmail.com with ESMTPSA id u20-20020a056a00099400b006e47300e4edsm2456787pfg.183.2024.02.20.04.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 04:28:52 -0800 (PST)
From: Lincoln Wallace <lincoln.wallace@canonical.com>
To: brgl@bgdev.pl
Cc: corbet@lwn.net,
	lincoln.wallace@canonical.com,
	linus.walleij@linaro.org,
	linux-doc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: gpio: Add a note on the deprecated GPIO Testing Driver
Date: Tue, 20 Feb 2024 09:28:48 -0300
Message-Id: <20240220122848.17864-1-lincoln.wallace@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CAMRc=MdoUuOLTYHu99+c_AVhnDZ5LkKHkYJ0D681fcJV_aW2Ng@mail.gmail.com>
References: <CAMRc=MdoUuOLTYHu99+c_AVhnDZ5LkKHkYJ0D681fcJV_aW2Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry, please ignore my last reply.

But okay, thank you for letting me know, and thanks for your time.

Lincoln


