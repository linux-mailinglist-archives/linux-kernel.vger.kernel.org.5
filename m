Return-Path: <linux-kernel+bounces-149576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2FE8A9305
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8255B218B7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB8C6F060;
	Thu, 18 Apr 2024 06:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Lspfswbi"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04271EB46
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421574; cv=none; b=YMtPChfr8PWOL20eaBEgBHo1XgFycVh8f/IKMUfIJIrtXcb1RGis/1NFtuhR49+IaLSFNhdV2vliYjAmoCmW7gBKBkr/MLxZwMj1H+sReF7zzloEal2hcT2VAM3MtU4srvf/jnV4dKtV4VXRcKoQxQ2rsa39Fq1jjJ7/2F6AfaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421574; c=relaxed/simple;
	bh=K1zbq6PPOj2Nt3RTfjEHCocHtfTNgnmPAGzwIG6Qz4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YL6hB1hNx2MnGXGX6gaXP+bWksxRUUehX0l+qYOnS9WPWOMtC5ZMbsj6bpapqudlE5uibzPvrR5+bWo2lowuXquLESRDG0/ts3LVjzVItFcKG+WPwHdlRLsXqFYVxdlyRjZGll5WCzsTRaj2wt6rQIdyB9qHAf03f8LVwRdf7d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Lspfswbi; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c718ddd87eso208960b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713421570; x=1714026370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g1v/jI2hXzIfhgMNddOW2kA5hdfBy4Wa/kY3ba32ESU=;
        b=LspfswbivaWYJ6C8wbsOhkNP/5O8Y1I8LtTTl+To7SgM4rZGidgEMcnOl2OaGWqB+P
         17m6uU1qHJWeVJN7vX5okxpWyvRvFDkyLDCom+ry7/fBFw47Q+kowiCjS6LLW578E5SN
         w11EpW8druCfeF89PmJcdk+vy7f9L0GuJWwBJ3qVdNt7BRwDNTr1G06bM2bLIdhw9dsA
         Z6PNT0kE9FyHBkimOfsdpg+xeFnZTmiRB/QFI7CFhGMNBvLvSBIKEK2hq/R7b02ttK1z
         VRHS5HAa6cZ0Y+9MdP5cVfpzRQEHvflFKCc+Ks4yVi+f4+SP4tsHSOYgXyyhsUTKPtgD
         G/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713421570; x=1714026370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1v/jI2hXzIfhgMNddOW2kA5hdfBy4Wa/kY3ba32ESU=;
        b=RarGD0Ch/Q+KRuXEV9I4qq3DVU61oNpuEUYvUccwyEqpJNLpALHCp6kq8tUSTlVarF
         Ck+tH8JowEMRc+J2ICOOToJB01/cJsGjvn1ySqklfQnA3lMFBy222AD3yIlb3105J+cK
         YglhrMYgSFWPvbgWjdZn2u+MUvUQBbpCWymCvk+t68UnyciCpjzeTmCfgFcm24XSO6wk
         U2y2s16OTk+pjybJGNKkksch7O/xQIa7dnv2DJ4ohWSkVv+Z13+0sFciz3Pg8n91A1eF
         54ruNmB53sL+UaxZUljLFS1aweyCpMPmlSyX6s/un0gvF7/6dGooY693+OmQN8zu7Arz
         yDZw==
X-Gm-Message-State: AOJu0YxLDNtYMQEc7SKJFi9eqVRzQvjwOEqHmSSNDUAnwfKUVp5dGGbR
	MIEE7MKA3rmIiQrwwWTX93s2mHOer2qjks/W58aUl25GcJVLGCv0NisPhtkP/taVcFhjWL18fT3
	u
X-Google-Smtp-Source: AGHT+IGhj7EAWggo4CaUaClDH/BTuOmWGmN3tEcf9kJ6Ea3ULSg/eqjNI+uRAJpd+fVuL7oXc0AlHQ==
X-Received: by 2002:a05:6808:2803:b0:3c7:bdc:c709 with SMTP id et3-20020a056808280300b003c70bdcc709mr2028041oib.14.1713421569927;
        Wed, 17 Apr 2024 23:26:09 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id s21-20020a632155000000b005cd8044c6fesm666392pgm.23.2024.04.17.23.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 23:26:09 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Cc: mst@redhat.com,
	david@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	akpm@linux-foundation.org,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 0/3] Improve memory statistics for virtio balloon
Date: Thu, 18 Apr 2024 14:25:59 +0800
Message-Id: <20240418062602.1291391-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC -> v1:
- several text changes: oom-kill -> oom-kills, SCAN_ASYNC -> ASYN_SCAN.
- move vm events codes into '#ifdef CONFIG_VM_EVENT_COUNTERS'

RFC version:
Link: https://lore.kernel.org/lkml/20240415084113.1203428-1-pizhenwei@bytedance.com/T/#m1898963b3c27a989b1123db475135c3ca687ca84

zhenwei pi (3):
  virtio_balloon: introduce oom-kill invocations
  virtio_balloon: introduce memory allocation stall counter
  virtio_balloon: introduce memory scan/reclaim info

 drivers/virtio/virtio_balloon.c     | 30 ++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_balloon.h | 16 +++++++++++++--
 2 files changed, 43 insertions(+), 3 deletions(-)

-- 
2.34.1


