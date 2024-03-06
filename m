Return-Path: <linux-kernel+bounces-94160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A313B873AC3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101651F24DB2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EB5136668;
	Wed,  6 Mar 2024 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DlnXMe0s"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AC8135A67
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739326; cv=none; b=Eb1qmKFv8o6XHc1r5wv6w+KIM6hRItCiXXdk0Ck2ZSoDVLULDv4yRh+4E/bR5psC4vCMAfPAn6CtWKHJ9nzA6aEKxMl55McAyCsCamM9yrD/UPGjFOVC77Y2WE6ww3NWMDOf47UcNbFwJ6/VI2Gbo/pryV7TWegcRZpaBBQJAR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739326; c=relaxed/simple;
	bh=coDEBELyHytZgJGUxxNrqmpXX/u1mAEvRUIhm5eyXFI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MFOiQsG8+BO+JxVB3ebDftfiAQ8Js/V/JB+BonX9lnTFynOlmZPHw1HmUwAXGnsZbB4GAeWD+1KJUotf2D/sswEh8IDNsK8rNuJoqLOfXtbAlG2QFlSvDldL+/TepfH49q6t4PRXwVNxdVFNbRcBgfvCZwLxo/8kv9ESeTf21SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DlnXMe0s; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bff8f21b74so82841339f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 07:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709739324; x=1710344124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndzrMcdFbtFzcUEv7S/hPRIsu22OrypbCYxhbFhfSK0=;
        b=DlnXMe0s6GjMeGCtYMKQw+10e+pj/scJUgevy3/AOSgAPkp9qEkcGROZ1Qc3FolFnM
         ZD/3Ch7MXjrgcj2sJldpN8Mx6RQmQ5N0XzHGRzzO3foetBYPhv3K2rSz3cpYCbPMrDOe
         FTSXrczrFNgxHj4d+jReH8Jg9tl3IIW9+68It9adHbCtFI/TK8pDVWQgkqwsvZuPpDH5
         K3itPJb9wrRoDoLBcURKwoiRjNF6T/3Z4cTaC6g6Skk1jx1ARXKS3JsMzfGIhWQ/sR9Y
         XidqYK5AOhiJYJCjjBDs9qnYvQvAfNCjhMW/9TMnD8Bf2Dc5pxUPWtovKZHXZ+Lbcywd
         eEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739324; x=1710344124;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndzrMcdFbtFzcUEv7S/hPRIsu22OrypbCYxhbFhfSK0=;
        b=E7VZ9Dd+B1a2OZ0hoRe7Mo5kOQMfBwZ6QiwUlWSfME/JeWghWdbWcaJ6BScDRh+Rhe
         7YUQ0S/oph69IDuBK/M7svMr+lH/cKJvEQHlTuTb2AYywJodRoLj1T8L0VUa/uzUS31r
         3W8E/ooDY/g/qNjg711vbMCdw19vvcmuvgTeKonb+xxVzpS4sdT+KG6MySgGtAfd6K3+
         nBkagi7u9CeBiMEtTfEfycOeHNPqwIVsy7PmaSFg6yA1bTfCcN/StYSL1cli4NtVYqSt
         1jGmZZZ6zA5guQDMnTV5MsuXhm6lzZYWM7EldanzNRFsrNBvyyoubRDCiqH91CF/7hBv
         l+XQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7Cg8Qga/ndWIJl86y+M47QVp6rdn9kf7iatE1r53gxi5p54p+sM9VUg5O+jaqEuV+G+8+dVV1AdZJxhGShMrwg06iX+ElYb0pLgi8
X-Gm-Message-State: AOJu0Yze+hSrs9dL3SkvVqXDlrLK6qg91nLV8V0Nkr7zfW0Q0P4V3h5x
	XVqsd7++qYYbEEhnoYIjnrE93AkeqHlfB0GKqLXKq7eS79KeWALhf7Yb8Dj93Zw=
X-Google-Smtp-Source: AGHT+IHAk4RROeD2N2tXKpE/nDlZg7iNaPB3hvQ6fE7kTnS5oEUXHSZ3ndChfXgOcqMM6edCE/tX9g==
X-Received: by 2002:a05:6e02:2195:b0:365:1967:e665 with SMTP id j21-20020a056e02219500b003651967e665mr3655500ila.2.1709739323898;
        Wed, 06 Mar 2024 07:35:23 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t2-20020a92cc42000000b003660612cf73sm324467ilq.49.2024.03.06.07.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:35:22 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: jonathan.derrick@linux.dev, Li zeming <zeming@nfschina.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240306095608.26839-1-zeming@nfschina.com>
References: <20240306095608.26839-1-zeming@nfschina.com>
Subject: =?utf-8?q?Re=3A_=5BPATCH=5D_sed-opal=3A_Remove_unnecessary_=E2?=
 =?utf-8?q?=80=980=E2=80=99_values_from_error?=
Message-Id: <170973932246.23995.13533628750920014175.b4-ty@kernel.dk>
Date: Wed, 06 Mar 2024 08:35:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 06 Mar 2024 17:56:08 +0800, Li zeming wrote:
> error is assigned first, so it does not need to initialize the assignment.
> 
> 

Applied, thanks!

[1/1] sed-opal: Remove unnecessary ‘0’ values from error
      commit: 147fe6133477b9654f0ede339ef9267425955e88

Best regards,
-- 
Jens Axboe




