Return-Path: <linux-kernel+bounces-137842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F5389E832
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8A8286F56
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EBC125CD;
	Wed, 10 Apr 2024 02:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H7CD6fRB"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFDB9473
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712716322; cv=none; b=qHweKXVVkgAThGoeGD1byrUcsGfvXrrvyNqyxrX/BFeGDVTKQ03a2sbrJtIids0OaKDK3VlhGuDjni2PJ1FNRjQJuBP0RzLLKQUoBUzsYXkKzfk1zUDhNTsaLPtXmhVNfO/ZyW5CTAFNT+s70Ri5DbDI1I8+W/I9I3DL8ZeIOMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712716322; c=relaxed/simple;
	bh=KszawLlCfqBX5u3rVG0NvzmvK/754HFncGX7jVg0qxY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vc+eY5VJ2woNa1zBwjpl55ws5HkDllKoMq25adEY2ttv+tDNYrlhGx+i0Zmz5X7xx2o9NHvBEtpwLYL8iaxXWxr8S77vzG1YiRLz3tW3y2EUCh1vZxBbL0Bgqo4BwUGU+rzAB47ZQv0cGFnSr79NMlUcft978/NR1i4VocsXIwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H7CD6fRB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e3e84a302eso23868395ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 19:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712716318; x=1713321118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7sJB/mea+ne4UFf8C44UTKqaf9B7A57oFQubr1xCfoI=;
        b=H7CD6fRBN5qrbJARl/fzdCmRnD3qqryKyynhwWbYSIxuVcnNMcgu2LivLl1N38rfVk
         NJ6jVxygQ8pdSmMwk71ejOKTyBbFlIodb1fPNNHLSenGTReTqGzvM1n70V8LHZu7WBJF
         W6HEEhhaFhKHNBjQZd8419vUqgIbmQC10u5Pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712716318; x=1713321118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sJB/mea+ne4UFf8C44UTKqaf9B7A57oFQubr1xCfoI=;
        b=jQITauyGwvfMvPv42SjRmlailUwMYyK26P1uvpk1d7JARAkk5JS/E+E5QgcC/lrF1c
         GR35WVcEQ268KYhKdAvNiOXY5r+Rxnl/6bS5NH7A8uKtlrpXboESeHe1/UozjkqAQvkB
         YNGE11/Zz69CwOIeIr7ZPiHfr0VZ+07uG6tXaA3sYEdgxHvEzAZ97QcUHTnsvMobkNdj
         8kTHoRvb7dqT2hA2rjNBYPE3AvRPzBDERhroqRMY2OqglCpc13XnF6U64UDfZSHyK+fF
         KoHnSDYUxC5nPTe1ZeJeghZZUQuOWPzAH+kAxnPNbHBjxQjLJ+GXpKG2slqM3vLxOGOp
         KsMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHNiJPZioiT64eAQhHrEpkflxg7IDtl/YbSHmfiDandNQRTj5qUyvK5B9qgiYUkV/fqs8PQ3UyKkQgiJjRl8/x/05kS7EhVeTVnPoP
X-Gm-Message-State: AOJu0YxPqgEjzs4VGMuLXFWCRPCkq3BzZ7k5FfZGtPBCYDCP73X9Mx18
	e0R52qH5t8PBf6w9LB7wJchycQQqZ5BPXzgO4p6MI+NhasVSgtchxe2IDvDITw==
X-Google-Smtp-Source: AGHT+IHClp98RNXSKgnfnzn46Mc2LDj/wf+Cyy5uZfzjLtUAplxwmqUCk9V8CgCGYNbpysszUmj2iw==
X-Received: by 2002:a17:902:7008:b0:1e4:3ad5:b6d6 with SMTP id y8-20020a170902700800b001e43ad5b6d6mr1512978plk.37.1712716318594;
        Tue, 09 Apr 2024 19:31:58 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902d50700b001e3ee552999sm6406385plg.291.2024.04.09.19.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 19:31:58 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Kees Cook <keescook@chromium.org>,
	Charles Bertsch <cbertsch@cox.net>,
	Justin Stitt <justinstitt@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Nilesh Javali <njavali@marvell.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	MPT-FusionLinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: [PATCH 0/5] scsi: Avoid possible run-time warning with long manufacturer strings
Date: Tue,  9 Apr 2024 19:31:49 -0700
Message-Id: <20240410021833.work.750-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1911; i=keescook@chromium.org;
 h=from:subject:message-id; bh=KszawLlCfqBX5u3rVG0NvzmvK/754HFncGX7jVg0qxY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmFfoZGm+w5zIvLCsYnaFCm1zKDHNOj0+xiwYgY
 QCyzpvIZWGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZhX6GQAKCRCJcvTf3G3A
 Jo6wD/0QQk0StqwBxMN5hxnRxuq1LlsSW6z1VwPSQbvxTQhHewhbKVcSmede+va3JiKcOFnm8db
 Z5tyz10tEr4E1gWXWMfMZvp3HtZQNej83u3OZdrdgfrHNr06E5twCcfmS/LEFwwqdsVSr1AsN6k
 8soxXZSYHKsCEyiYQGYGBIv/yTn91kepLo3oP6UE2sF0YF9th4p+yYovtTDtcVI06xFTPTimcOA
 b4yivDJtG0MuKjJPtWCEeUSHRv7I55eY7Um9YoRMh6AwkgE6Sq4FuogJQjcQ0/cADCB9UiFMUmL
 5aQR30QXfusAOfgG4b8M/PJtfFHv0zf8gd8gYYiSxiR5DQ8eNKp4h4CdLEcHDYkpMOsW4J/mygX
 7jEPX/+3EiWE72P4eYnfnzhw5Gb28anIEI4gCcVOIGQT25H2FgFN/7srJ440W9vmlGOm/alkpBP
 zMo4aorHp0hSy85xDtvmFbFM8tKG4tj5hOh5U4VPLVUlwzk8OH6sGJ0waSHdNIsQBScGBRk3kXG
 MP+jzndBxOoaWnXkHrK1b3/wIPPlcYG5BkXxqALuRo63UucckCttvJcNPF75urxyQ/1nfgGfwNU
 JJqca5Pli5JfQqGyfV+y32MEwpMfCj6JqHDwe4WUQDJfpZnS91bEvOepX7jB03lPrx+7ZrJ7Z7I
 Dp8Y9D/ WtLzpPwA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

Another code pattern using the gloriously ambiguous strncpy() function was
turning maybe not-NUL-terminated character arrays into NUL-terminated
strings. In these cases, when strncpy() is replaced with strscpy()
it creates a situation where if the non-terminated string takes up the
entire character array (i.e. it is not terminated) run-time warnings
from CONFIG_FORTIFY_SOURCE will trip, since strscpy() was expecting to
find a NUL-terminated source but checking for the NUL would walk off
the end of the source buffer.

In doing an instrumented build of the kernel to find these cases, it
seems it was almost entirely a code pattern used in the SCSI subsystem,
so the creation of the new helper, memtostr(), can land via the SCSI
tree. And, as it turns out, inappropriate conversions have been happening
for several years now, some of which even moved through strlcpy() first
(and were never noticed either).

This series fixes all 4 of the instances I could find in the SCSI
subsystem.

Thanks,

-Kees

Kees Cook (5):
  string.h: Introduce memtostr() and memtostr_pad()
  scsi: mptfusion: Avoid possible run-time warning with long
    manufacturer strings
  scsi: mpt3sas: Avoid possible run-time warning with long manufacturer
    strings
  scsi: mpi3mr: Avoid possible run-time warning with long manufacturer
    strings
  scsi: qla2xxx: Avoid possible run-time warning with long model_num

 drivers/message/fusion/mptsas.c          | 14 +++----
 drivers/scsi/mpi3mr/mpi3mr_transport.c   | 14 +++----
 drivers/scsi/mpt3sas/mpt3sas_base.c      |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c | 14 +++----
 drivers/scsi/qla2xxx/qla_mr.c            |  6 +--
 include/linux/string.h                   | 49 ++++++++++++++++++++++++
 lib/strscpy_kunit.c                      | 26 +++++++++++++
 7 files changed, 93 insertions(+), 32 deletions(-)

-- 
2.34.1


