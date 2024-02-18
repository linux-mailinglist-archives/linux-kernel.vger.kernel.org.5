Return-Path: <linux-kernel+bounces-70195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFFD859497
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C091F22C4B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74CC4C6D;
	Sun, 18 Feb 2024 04:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hAjeusk3"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7179F6112
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 04:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708230345; cv=none; b=QFKC3f3JQCMmUGLT6Ds9NwuYLYaTc21G1ezGo0YFcz6HTN7VRAltOvzzFj3/pMZEn08XH7w1g2GEaQ5zpRXSeocmZlbnsf9JegQO73R7DVWD/fq3/KLwhOpD7yly3Gy4ctYeDhesDiUTIguA2G0amRdIJtw+QgzjPGmXEg210lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708230345; c=relaxed/simple;
	bh=8X2LbBluiP62PhY4yTx2Vm7OR5mhIBYACk5drh7CJDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=smvrKswXF/AztZozSHdjYkXI7SuVDQQLGNI3y2VmPP0R4sYaGrVkM5nVkNM/d01DtnKGYfYqX/lZ/AHybFuU0symK1CsF0ZPW7QwQGvJwRk6L0z6kPC8Qj/IczVOYlA4MXbA0/X6qR/isFABYgf5dmBh7CTr+b9rg4PvSaxxN14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hAjeusk3; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5dca1efad59so3020150a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 20:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708230342; x=1708835142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PPPOVToP9KvYFFYAhd+euhiEp/R/1IO3VQIxg89zLZk=;
        b=hAjeusk3a+b3Tdepb9qBRtSsPMYj6LSe1dil95hBwTw4/eFeSzYzwIz5A11Zj45vMO
         br/EkBaWN1hyMcgEnDyagfI4Ye7UDtLdUnkZWife3JCcf6xODHgL6woJarTXY1rYcqFa
         h6LHzIRQa+NRk9a42IvT2WvKrMMbz3+6iKUe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708230342; x=1708835142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPPOVToP9KvYFFYAhd+euhiEp/R/1IO3VQIxg89zLZk=;
        b=gQ5A9H764GeeyXrMQXWhnRAlt3uhCgmOfOQGkrINnjX2AzSq2qmc56mC9H4Bkxm30L
         6luBxp5iAxEnd5l+RAx4Vbv+loD9RQKWvVsV7os1R7cKh9qeUKTQHQ2g4Re9qeRDckge
         JX8BpIv0FdxZhyFTi50U7w9r4ylppVCosKJXdwj7rXEjIJHMBGYmZvTVUD8cQB9u7Srv
         eQE5RSW54YVPwBibczq6P09QpQmBxfxNi1RL2qoRGwRzIorJP9fwqE5PfcQMcQGBuP1L
         9ycFIwZHeHJtvK9/2U2DmbRGpU2YhX6J4sGnkEtGUfkYdsWTQZWBQ1QBDLlWZVvpS49h
         pujA==
X-Forwarded-Encrypted: i=1; AJvYcCWco7d/+njYEPCpkFB9+vqV3Lbuj3sDWjlg3StSyFKuF9Y6aBBTLtFoFdZ5ZFBrJhR9R3Yp3ZNiPcSl/ggly6ECfAl6sxWoOoK1ERp9
X-Gm-Message-State: AOJu0YzxiW8V4t3+CMxjymj2irl+ky43K0h4jgOxxx7aohQh0aEgVa5S
	zf1qb1hy/TOU1QBTdFSt2tGtfd3uedKzxQqKZQmhsrwT5pVGSN+LZ9YoKKDn6g==
X-Google-Smtp-Source: AGHT+IFjk09QrySxOgBtDCo76+mGw+pZNd0U5JFGwf/tqqImzzxQdPNFpc9iNKIfio5NAiR63Hw3VQ==
X-Received: by 2002:a17:902:b20b:b0:1db:4b23:f97b with SMTP id t11-20020a170902b20b00b001db4b23f97bmr7487589plr.59.1708230342654;
        Sat, 17 Feb 2024 20:25:42 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jc15-20020a17090325cf00b001db54324488sm2142726plb.38.2024.02.17.20.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 20:25:41 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Kees Cook <keescook@chromium.org>,
	Navid Emamdoost <navid.emamdoost@gmail.com>,
	Michal Kubecek <mkubecek@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v4] nbd: null check for nla_nest_start
Date: Sat, 17 Feb 2024 20:25:38 -0800
Message-Id: <20240218042534.it.206-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=keescook@chromium.org;
 h=from:subject:message-id; bh=0R8zCu0X/ARVuSqlyl7fu4di67hYDgO+9WqGqz+HaEc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl0YbBPe25EqmI5l5nzuL7+soJkeVhsbtCpCkDH
 ubGmi/BvUiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdGGwQAKCRCJcvTf3G3A
 Jm4SD/4k25Oc6EkBmLy4hVwdpNNdRv+uyAuAXQKD7aOBOpyDpt8qh8Wjxpe+PkBlP8wDVT7g+hi
 SDxOzbm7NvrlnYL6aF9fyDUz1W2tmTVvVnTJuDOIxdMRT4Z9Eer9IhO+LEXmuY8WevRZrbFgnKl
 /n+ZC3HYgck0RexH2TJBbMulSVwwh/rgxqbY4NPz19YLMRs1W4k+artJg6buZ9B+VEFT1WYoNU3
 r33Kr5nru90Yd1QyCEAV28QqD37LynEdBgkUj58fmnzWx5hYluvUR+cSDvtt+ov7Ie5/bcBOoXG
 lArRTlM6G3GMBDcPWXs8AZ3jJPc3YnyK/N9yvyL0VKqfJQcErqJy2RhCS0PbLZkKjQW1ofg3cm8
 3QKhCRRkRDKTCx6FOL7fNT+P5ealU0YBNhatm4gAUl/+9Bn7vTXqWt3NQ8XyPm8TYgf0R3assGN
 NRnf4P/0HkcKTOIx9w7FC7BA2jMXJJAxXxVUPlFNuznghWXsPQQccfjqxjibsjY7bJBa05ljLo8
 7rLaFHTHiVQe8oVL5RR8joZAmlHLGgQjUxLAVm+VoJrP4QMKUOW6wCAGzHWJnFEPupswbmlV/eZ
 rwitO9926hht8LZtRlvZNm2vco0tFIvBmFgkJ0nO2ZuhY3cWZ9sOA1zf70bgn5re+XXe2oYEpFe
 Qx6xzOa L6H7WvAw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Navid Emamdoost <navid.emamdoost@gmail.com>

nla_nest_start() may fail and return NULL. Insert a check and set errno
based on other call sites within the same source code.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
Fixes: 47d902b90a32 ("nbd: add a status netlink command")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3- https://lore.kernel.org/lkml/20190911164013.27364-1-navid.emamdoost@gmail.com/
Resending on behalf of the author. This seems to have gotten lost and
has been getting tracked as CVE-2019-16089 ever since. For example:
https://ubuntu.com/security/CVE-2019-16089
---
 drivers/block/nbd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 33a8f37bb6a1..b7c332528ed7 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2433,6 +2433,12 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	dev_list = nla_nest_start_noflag(reply, NBD_ATTR_DEVICE_LIST);
+	if (!dev_list) {
+		nlmsg_free(reply);
+		ret = -EMSGSIZE;
+		goto out;
+	}
+
 	if (index == -1) {
 		ret = idr_for_each(&nbd_index_idr, &status_cb, reply);
 		if (ret) {
-- 
2.34.1


