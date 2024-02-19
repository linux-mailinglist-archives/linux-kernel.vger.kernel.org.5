Return-Path: <linux-kernel+bounces-71130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B75585A10F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5421C21E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8E328DBC;
	Mon, 19 Feb 2024 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNDt7bpO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AC928DA0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708338823; cv=none; b=W/QvBKSeydzp7vCp5UHi/A5E5EG43IocOpcOnde+/XmVzDD5Exq6bWUUypIVHOagyaXdbfNQn1naiol2rR9TNTQVz23TffkYym6sGHkuiiUH7WyS+932QBinvUuFAH2Ke4ODepj9QjBKBh4dLBbBOU+6rMBzkWLQpbSZGifEIaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708338823; c=relaxed/simple;
	bh=SULjHKF6QtgiPOkWISbPbw47xCTYnymy99P09bdIJNc=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=C6D9IUKHCPGcPBLSImutiFDtH+Q97X+kl5Ktgrx8mK+YAGBaxsoDMd7wOXHFzF9Hea7M7n8b5zPqcT2uqsS0QAaITnnjMbjF6IjwoTJ0nL6K5oYL8/wrvi5aQTX5rqBEWlx/V21ly7lHnHlRyM/U6AnFDZ71uUNK67qU9kLl144=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNDt7bpO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708338820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJRU4uALKxhx4r7SpSYo3olSdwrEbW5jzxK5ltbiNOI=;
	b=VNDt7bpOBABm8nkm3Qmzvwok858dtxIloz5WjpqTKsbyZ5XaHyutfd41e7kqTmHuRZR/cR
	YXY42R+zJuCyYWmS4WJiN2P75kTH/tiFkG9bRh3SAInbrqQTYMYx6F1WAErt0uMbwO5MHT
	rbee+zWtDa8ZgqBDlWBTeOR6cCJG/pw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-37UTrRGvPkiRbvpTfzHnZg-1; Mon,
 19 Feb 2024 05:33:36 -0500
X-MC-Unique: 37UTrRGvPkiRbvpTfzHnZg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A38983812596;
	Mon, 19 Feb 2024 10:33:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AD0BC1BDD1;
	Mon, 19 Feb 2024 10:33:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240212083347.10742-1-d.dulov@aladdin.ru>
References: <20240212083347.10742-1-d.dulov@aladdin.ru>
To: Daniil Dulov <d.dulov@aladdin.ru>
Cc: dhowells@redhat.com, Jeffrey E Altman <jaltman@auristor.com>,
    linux-afs@lists.infradead.org,
    Marc Dionne <marc.dionne@auristor.com>, linux-kernel@vger.kernel.org,
    lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] afs: Increase buffer size in afs_update_volume_status()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <125562.1708338814.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Feb 2024 10:33:34 +0000
Message-ID: <125563.1708338814@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

I suggest the attached instead.

David
---
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 020ecd45e476..af3a3f57c1b3 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -353,7 +353,7 @@ static int afs_update_volume_status(struct afs_volume =
*volume, struct key *key)
 {
 	struct afs_server_list *new, *old, *discard;
 	struct afs_vldb_entry *vldb;
-	char idbuf[16];
+	char idbuf[24];
 	int ret, idsz;
 =

 	_enter("");
@@ -361,7 +361,7 @@ static int afs_update_volume_status(struct afs_volume =
*volume, struct key *key)
 	/* We look up an ID by passing it as a decimal string in the
 	 * operation's name parameter.
 	 */
-	idsz =3D sprintf(idbuf, "%llu", volume->vid);
+	idsz =3D snprintf(idbuf, sizeof(idbuf), "%llu", volume->vid);
 =

 	vldb =3D afs_vl_lookup_vldb(volume->cell, key, idbuf, idsz);
 	if (IS_ERR(vldb)) {


