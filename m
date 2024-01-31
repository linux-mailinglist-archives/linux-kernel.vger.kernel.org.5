Return-Path: <linux-kernel+bounces-46600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFCF8441CF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E085428A7DB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDBF84A3A;
	Wed, 31 Jan 2024 14:25:22 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86BC82896
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711122; cv=none; b=VpgyrRvI2LRqYOIaqBWQ27Nm9DrTm+sKe2eLHu6k1Xm/r04ybwWOKMpHnWHvKiFCi7D4q7uRZNAnwFwF5/iNcZD7oBxQKrVdbV0GHUXiYZyD4mbKOJJTqznxjrFzrkz31WOSXOng+TFsrXxvHU7FX2pPdfbXfDf32AHrdyk25Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711122; c=relaxed/simple;
	bh=KK3f+0QHqzxLUrZUIBsNRGjDngWCh9oxywwOoLxYUbY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H0URmUgx6xVYoyk8hbvfmDK9muu97VqeCCVVZsTTudiueULajM9QeNLzOY7RvIyShaTkk1oByrhGxlTbWYa1gElOk8vF2RIT1wdqQ6zCJiFLBOXX74ymx5+2DygwehI+m5crx4LCLIABn34XjraMXJ6ba/PpqRtgN8226GTsep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36387d42a2bso21115175ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706711120; x=1707315920;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KsBguGaXSUanPQe6czsu3wg/krWK0mlrHig7Ntksdb4=;
        b=f2Zo8wR1SHorvd9HYO+oEBIk9gclOHhBfb6y2CnzF/3P1SM5qE3+hUGS2NnxFTSjFL
         f4qg+mIrQc7c0zCk9sNdZzxGosg9GWttJi+txoPpl94v9O/etbQbrr5pTzF3KVZfJ5Gc
         KtDBT5dm/cMug6td1vlo5YBDggyRe8bgPlI0Vf+o8/nVFCyd7nUk+7uhfHK038FzT88d
         +GtS226XHY/XJbzKEthe5iNc3ZphJ9tz9a4mkHwoPH+vQuZBtj4OlqKJdPpPJECE7Rv6
         RinKJjUWc2k1IvBKF6Yn7sK0IPkybTS1Ncv6gGdwKdo3IZyFxSUjFbLQCp6SlPgT5LeH
         khoQ==
X-Gm-Message-State: AOJu0Yza6ilTBsM36OBe/ng4G4juX/fMYwzVSHMyxh4tTHoVo5BAFh2e
	dUQ/GzVtoGjjj3dt5J4OomIFPDf5Zs82aKMbn5eMHphzNUHrMEgspJTy1OsEx3prMNulR4llCxi
	9H3s4t4Ceasd09Cje0uk1VUZe6QXUkn0JFzdOAdAfy2O+CPtWvjekuixyfw==
X-Google-Smtp-Source: AGHT+IGmuc0iBa0asveYqMZ4StWoQ1o1mdMzG/3DtuOCC8heN8xWflMUx8e56iBWqUZDfcHIbWo7XK+BGedWuWY29B5bSNUlvwQC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b8d:b0:363:7bac:528e with SMTP id
 h13-20020a056e021b8d00b003637bac528emr166970ili.1.1706711119914; Wed, 31 Jan
 2024 06:25:19 -0800 (PST)
Date: Wed, 31 Jan 2024 06:25:19 -0800
In-Reply-To: <0000000000007380e8060cc9c98a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000096eb506103ea671@google.com>
Subject: Re: [syzbot] Test for 5142b87a9abc510e14fa
From: syzbot <syzbot+5142b87a9abc510e14fa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Test for 5142b87a9abc510e14fa
Author: syoshida@redhat.com

#syz test

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 2cde375477e3..878415c43527 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -1086,6 +1086,12 @@ int tipc_nl_bearer_add(struct sk_buff *skb, struct genl_info *info)
 
 #ifdef CONFIG_TIPC_MEDIA_UDP
 	if (attrs[TIPC_NLA_BEARER_UDP_OPTS]) {
+		if (b->media->type_id != TIPC_MEDIA_TYPE_UDP) {
+			rtnl_unlock();
+			NL_SET_ERR_MSG(info->extack, "UDP option is unsupported");
+			return -EINVAL;
+		}
+
 		err = tipc_udp_nl_bearer_add(b,
 					     attrs[TIPC_NLA_BEARER_UDP_OPTS]);
 		if (err) {


