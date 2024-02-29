Return-Path: <linux-kernel+bounces-87574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2556886D614
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341981C2420B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAC316FF4F;
	Thu, 29 Feb 2024 21:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OhvjvEUv"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F9A16FF21
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709241813; cv=none; b=NiURp1GdRKIfmEtNFdUTx6grReP4iO7fXV+gVH7vOfv9+kd/12pEmhZ0CF6Uqgmkgd8rYV/jLAnFcwA4SGfxTlIBoJvjZ53UcIc6w8iA6ewV6ITXO2GGih9EWUPXmbOUF37VGfEv7Or9rl8CIbtzx8SNb9PqzhgRVjC1Goe4ohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709241813; c=relaxed/simple;
	bh=VjPiDMf6IhNaW+cu762GVEnCAc1qZeJ+AXh7xICr/eo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UPywW64MDNEeD1AJZhxYM2kc90xWWhnjaQU130vgFZXGHcJC4S0hKzOWKqvxgdRFhcu6oTZxfO1CsHUn2os9D/R2uDfuuY+IIg81d7JT9GEPMUh7JRMTVmLNMSnvddqLBbZzAiwmn+/SeLJiW1QvV2qzaDgjtYPDSGleVU6SGHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OhvjvEUv; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608cf88048eso24050777b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709241810; x=1709846610; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fLhWwQ23CyyTvDsLOK851AhQhodJoK3lOakZm//Wnio=;
        b=OhvjvEUv5RXKCUisVhYiqDWeUklAeaS3hGRg4KGnR2UMBDVg1Vjq/ZK0dkEnNLGsin
         rT9+I6LUjj8o/9fYKgT0s4kmJQ8KN6YxlI7zO/Zo+rq4ELFdQCUGwX/QDDMYs4gurwcI
         sZkWN5ns7xDV0q+JPZOYPLTro3EPHMVcWj0BhKAuZyf37uKOUN2rVoWG0J0NG5u+d68t
         KCvGCAsW9t+aR2FlYAqZqtKu/q8ci/rZs9rgMMtLfrMUxDEKmr0VfodE8Y27yWObtgE2
         fGuiG78jL3Lh9O0lBVMsp9D5STMXF3ySNIzOSSwnBVz+UexlLkqUdqm0HGwdK9ebflMD
         Ticg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709241810; x=1709846610;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fLhWwQ23CyyTvDsLOK851AhQhodJoK3lOakZm//Wnio=;
        b=bKN6dVBOcKK0ARhZRVG9jWHClZGHV/PBoriCbB90h1Rv4hzcN/peIHqxyz/u2ZY3Ei
         JLEcqPoX+/HPswdY//pwbAiGD+/5UAJ9rJ+4pZyMCZGK22eqeTrPdw1i80u82sJ4D9M1
         yDJoqBwtMkR81ZFMdKrUbYVJeQaZEuhE+WwAY44F/+BSLWdgeAasAuAg4d3by9ZC1iWz
         aZmgsXvV7R4fe+CnpPQewPi7ht3Xew5TL5PhMla5SN13WJM7JnRGvOaxyRs9HAyXXxDw
         zyHjpJdfhGpVtHqQWz9m443Q7KRha2ELJ5WW/QXYO5Y5pWU+BgWjzKBGEdfF7dm+l5Tr
         iIBA==
X-Forwarded-Encrypted: i=1; AJvYcCWZqPxZwiHhN4x1O5XRhHDRtWI42UlCPoxijbRbQEQXzQWJPiabPhBISYUoeXmPG4k8P2VnxZWzMsLEtYFQktS0tMi7cy9mVDDQQaKq
X-Gm-Message-State: AOJu0YyDIa3T6R5/9lQMTHq5sEF+ohkI1J/9SVndaIdF5DV+1gxAFr66
	kT0ySWA/EeEe2tCZnOPV0tNsvnnLekQSIez47SyhqFouo/yLa63gRhIIf6XqFkErPAqqcoSmeCL
	riN2hx0V5jvNHCQ==
X-Google-Smtp-Source: AGHT+IFS1dty/+rJQWw2sc3jcb3WwNJDLmAlgdfa2XsO6QwyCtrMLH5+4rkAyXpzjKCLMyIlAwCimbEcA1cqqH8=
X-Received: from ziweixiao.sea.corp.google.com ([2620:15c:11c:202:43b5:fdf3:8395:a655])
 (user=ziweixiao job=sendgmr) by 2002:a25:abc2:0:b0:dc7:48ce:d17f with SMTP id
 v60-20020a25abc2000000b00dc748ced17fmr800935ybi.10.1709241810564; Thu, 29 Feb
 2024 13:23:30 -0800 (PST)
Date: Thu, 29 Feb 2024 13:22:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240229212236.3152897-1-ziweixiao@google.com>
Subject: [PATCH net-next 0/3] gve: Add header split support
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, rushilg@google.com, jfraker@google.com, jrkim@google.com, 
	hramamurthy@google.com, ziweixiao@google.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, the ethtool's ringparam has added a new field tcp-data-split
for enabling and disabling header split. These three patches will
utilize that ethtool flag to support header split in GVE driver.

Jeroen de Borst (3):
  gve: Add header split device option
  gve: Add header split data path
  gve: Add header split ethtool stats

 drivers/net/ethernet/google/gve/gve.h         | 27 +++++++-
 drivers/net/ethernet/google/gve/gve_adminq.c  | 50 ++++++++++++--
 drivers/net/ethernet/google/gve/gve_adminq.h  | 20 +++++-
 drivers/net/ethernet/google/gve/gve_ethtool.c | 62 +++++++++++++----
 drivers/net/ethernet/google/gve/gve_main.c    | 65 ++++++++++++++++--
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 68 ++++++++++++++++++-
 drivers/net/ethernet/google/gve/gve_utils.c   | 17 +++--
 drivers/net/ethernet/google/gve/gve_utils.h   |  3 +
 8 files changed, 277 insertions(+), 35 deletions(-)

-- 
2.44.0.rc1.240.g4c46232300-goog


