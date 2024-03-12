Return-Path: <linux-kernel+bounces-100307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ACA879560
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2766F1F243F8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7427A71F;
	Tue, 12 Mar 2024 13:52:14 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BD7A939
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710251534; cv=none; b=Cip3G2e3cCG/nFMOa9Hc1UW8ifEYsPOhqIB5dDGhYZeEv8FXU8eA7SQ5Lba0E6ChoTarhK+PCkKVFFXJcbxfawHJ9eE6/q/PeUAwOvsbBsvqwvHJIuz0fLG4oBs8Oa3V3go2BZ9m9YxthmqXNNYdOyWVSqve9VwOSKe85nIkB+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710251534; c=relaxed/simple;
	bh=CcFRwB322LGtp0dNZVWDbfFecbOY4MMxCdh537eoH8I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gJyy7rV6G6+FNsE9ENNESQfnzqGPPOHqUYtZR6ZJsFFP82cjDSinJflD4UnrgsHrr0IxlmtICFPyS2jOhWEZL+gXy6VfGu3x48ogsJClMm4eqIs4keMtsCc2wuAqjpbnQF6QpJsQ7aFh6BtEIJZSNvTMD6Ehz97g/1gTg2pyIJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c8a98e52b5so259603139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 06:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710251532; x=1710856332;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVL6n7u9irY/XXq0R9kO5Vk3K/+z7RkaEdKNYOOG1vg=;
        b=ZElQNigv0P/iXONsdsXOwrVLrwOeDFOpLWy/OdwABWkBfHsSUAOjhl4EU2C1cmOjWb
         RB0HuwpY7OKHX3MZrOvYdN+8fPHcEKEY8FbUwrdpu4JjEsRGymyhXRKoDdYc/NNhSFC2
         absDJkpmBlHCGvR0sRGHjwMpqPHa5EVAcmaW0vsvWYdL7wWTooNcTZXhy83LoEa+TFQm
         3F3SzfFl0R1YFzSL7K5sdFvAzk0gTHD7fyRV2Ykf8VGI6ThrWK3T63WUyWvd8szpo4w9
         bY3lWqucpg/0s4hjixxPNHdiot1iH0GHS8EPOMG9DUaB0s6z1nZpH4BleOnNcSGTPgD9
         QKNg==
X-Gm-Message-State: AOJu0YyJETbS79WHqFPKfM2/Z6ALmkMS4rK7qgTC0rqDbPkEQcjssYfc
	d69zWcghNGcMr0IoXkmeoHZwMvOjn7KSs5gto35W2vIvmRY9G/zegt1D6HqjhiBtkIYPASgWyGu
	8eD7+WdUoK1rKmwlv4aZCRubBlKXoDaEaiaq0eFJm5g9adtfjkQtuLK9ZSQ==
X-Google-Smtp-Source: AGHT+IFj6zvgQMmt7pPppEul0jueKmLFCEcfbL1/JWEXUk2aLZZ5Y2sRsGIxss7knhblobl7rpwXV8IFyf6eXaujhO6HOgNBEhsA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1393:b0:476:f2cb:8790 with SMTP id
 w19-20020a056638139300b00476f2cb8790mr138138jad.0.1710251532095; Tue, 12 Mar
 2024 06:52:12 -0700 (PDT)
Date: Tue, 12 Mar 2024 06:52:12 -0700
In-Reply-To: <0000000000001663ea060ee476ea@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c23d0061376f73e@google.com>
Subject: Re: [syzbot] Test for 2ef3a8ce8e91b5a50098
From: syzbot <syzbot+2ef3a8ce8e91b5a50098@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Test for 2ef3a8ce8e91b5a50098
Author: syoshida@redhat.com

#syz test

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 6d14d935ee82..b983232e25cb 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -228,6 +228,9 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 	 */
 	if (ethhdr->h_proto == htons(ETH_P_PRP) ||
 	    ethhdr->h_proto == htons(ETH_P_HSR)) {
+		if (skb->mac_len < sizeof(struct hsr_ethhdr))
+			return NULL;
+
 		/* Use the existing sequence_nr from the tag as starting point
 		 * for filtering duplicate frames.
 		 */


