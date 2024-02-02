Return-Path: <linux-kernel+bounces-49567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DE6846BE5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6DB1C21715
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7715977F37;
	Fri,  2 Feb 2024 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3iJyvoC+"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529C477F2E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865775; cv=none; b=UUkmZsc4KX3PjpVKTyRpqK8X9vXDxoM+HGejXrHq5+sBYfOOjSPcUevPoxaqD0XLVwRozVmkvnEtpFGACWRJRQA10NehfRsQh9KAJ2AXzkzq+rMFVCvbHtnrFgRPxwZRNmp4W9235RySIuoSQc1krkiEJF1ZBbgt3Tm3tvLtO4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865775; c=relaxed/simple;
	bh=0NK7mEsHb+0WdInKdwCKKQgSWXPKGHPtGuWQPwU+gtQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=NdsBDU77aLgkaAlacfBIS3avlI0zPhrqCp+v4vNxUUv0Z3kxZm0kgleM63VMxtapsKaPYigtSc1BwlFAR+PSLqO41E3hrKyORV5Gy7tit/PgEhoMNu+Dt0IcPypWmSPLaIR0JXjLOoaLjFCQ0QfQFq36eg81NGeSzq+DVmwNV+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3iJyvoC+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6c2643a07so3358666276.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 01:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706865773; x=1707470573; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KwVIYWDlCwJBmQvhraTLkr4EOD61K4H2RbK+5DkYGIg=;
        b=3iJyvoC++rXBLj3zd0iZng1KVfjyFAg9LNslGHIcfnx5RBqU3tsbDMnw4eQcvuZgFd
         tDS0RNU7LwY0TVBNvuJwUZldEakIa73Bi7MTwfHmLXl9pTSplzyFyEoTZGF3KDCGhjQk
         kaT+x0hpIRIzUZRc+NJ0A7RxhfBITA1C5N/RJjbNGdmToOsQ2UaVOoIjTXnFjSGltIyW
         9MwWbQ4O1jCpeaEueC0EBcduFh6b0Of93oBd7uv5jFhy2A88ITT2JwYFhVXLipWxHFFI
         QOvBRjU5/+pUlnRg4IJX1Aj0c0r1PB9yYVSYhOTC1JdBfp/99i8/JsaBotm9MEPLDtr6
         Cjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706865773; x=1707470573;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwVIYWDlCwJBmQvhraTLkr4EOD61K4H2RbK+5DkYGIg=;
        b=QdSVEUg/D/smOUn9xx1YWQY+uSuLDxq6CZKGzI+Imt9N8+2fDW0N2pLN4V5RqCuRDb
         QRTJguKYdz4zkWYvssTLGvFDbRdqloX1uOI/ofi5ykbytKjgPhDeTtZsgYrrGD0onIUj
         nManX33wcNlsA+KAj4VO1dBQqERGpWo1rjFFFpURpIjqnf5Lew6N3ooG2ow4Azsb9skp
         lW7Tscb5xOfcx5Jwd5eNk4cNFNvaitpOEpGgAxRL9W+gMdz2iqjxDcruvKh3jP8hMnhe
         A6GN40F7DW7h8DmU2hYBGN+upWxbgwuFytGfuu+2M3Pz5YXwUgkELv+3VsZFzA9R7+dn
         FpEQ==
X-Gm-Message-State: AOJu0YxIzxsf8H+SItpLNHWkMN5OFtH2GCGBZPXmbmJOgnioeqUt03fC
	lXCq8aic76iwKPT4t5UoFCE4Dr8KmB1CAueZt5gbjxYqLOIgQfnAj+2mxtWrbHwOS4XI1vFRuyF
	6mPLnLQ2lr294HQ==
X-Google-Smtp-Source: AGHT+IHvYeUnAUwCSAJYPfydXasVcNItlUK+XAcxdDvNjGx/6awJ4ZCD0zHeBxjSzZzvZPtVy/oyeRfDkgWq1b4=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:6f0:da10:9cb3:5b3])
 (user=saravanak job=sendgmr) by 2002:a05:6902:1085:b0:dc6:e5e9:f3af with SMTP
 id v5-20020a056902108500b00dc6e5e9f3afmr704876ybu.9.1706865773363; Fri, 02
 Feb 2024 01:22:53 -0800 (PST)
Date: Fri,  2 Feb 2024 01:22:46 -0800
Message-Id: <20240202092250.786276-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v1 0/3] fw_devlink overlapping cycles fix
From: Saravana Kannan <saravanak@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Saravana Kannan <saravanak@google.com>
Cc: Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is mainly a bug fix with a additional logging improvement. Lots of
details in Patch 2/3.

Thanks,
Saravana

Saravana Kannan (3):
  driver core: Fix device_link_flag_is_sync_state_only()
  driver core: fw_devlink: Improve detection of overlapping cycles
  driver core: fw_devlink: Improve logs for cycle detection

 drivers/base/core.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog


