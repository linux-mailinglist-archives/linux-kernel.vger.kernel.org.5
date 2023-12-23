Return-Path: <linux-kernel+bounces-10606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D9681D73F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 00:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C03E282F63
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 23:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54D01D6B8;
	Sat, 23 Dec 2023 23:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwF6EdS0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BAD1D52D
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703374480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6MwvTNgc3edtUi1oD2vuk843ZSwVQ67y6EiHuffl3Q=;
	b=MwF6EdS0hS4wunnFxNqxu0gyUxu8YlRDon1INDTj5Wkf2UOc6SJEidd+nv75tuDmSZFzrg
	fyy2Cj924d0igY/THvYoG9I0JaCcTtvvSEh8shpy1e91zW3JJR7exTVhN2w3kEWJ24XM4e
	4FcIcrBICNfdzlAHrZSjjTpOfwQOFhQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-9lITgyanOQahtKf1ir0iaA-1; Sat, 23 Dec 2023 18:34:34 -0500
X-MC-Unique: 9lITgyanOQahtKf1ir0iaA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F06B9807F54;
	Sat, 23 Dec 2023 23:34:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0546951D5;
	Sat, 23 Dec 2023 23:34:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <0000000000009b39bc060c73e209@google.com>
References: <0000000000009b39bc060c73e209@google.com>
To: syzbot <syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, davem@davemloft.net, edumazet@google.com,
    jarkko@kernel.org, jmorris@namei.org, keyrings@vger.kernel.org,
    kuba@kernel.org, linux-kernel@vger.kernel.org,
    linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
    pabeni@redhat.com, paul@paul-moore.com, serge@hallyn.com,
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dns_resolver_preparse
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2592300.1703374471.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 Dec 2023 23:34:31 +0000
Message-ID: <2592301.1703374471@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master

diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index 2a6d363763a2..f18ca02aa95a 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -91,8 +91,6 @@ const struct cred *dns_resolver_cache;
 static int
 dns_resolver_preparse(struct key_preparsed_payload *prep)
 {
-	const struct dns_server_list_v1_header *v1;
-	const struct dns_payload_header *bin;
 	struct user_key_payload *upayload;
 	unsigned long derrno;
 	int ret;
@@ -103,27 +101,28 @@ dns_resolver_preparse(struct key_preparsed_payload *=
prep)
 		return -EINVAL;
 =

 	if (data[0] =3D=3D 0) {
+		const struct dns_server_list_v1_header *v1;
+
 		/* It may be a server list. */
-		if (datalen <=3D sizeof(*bin))
+		if (datalen <=3D sizeof(*v1))
 			return -EINVAL;
 =

-		bin =3D (const struct dns_payload_header *)data;
-		kenter("[%u,%u],%u", bin->content, bin->version, datalen);
-		if (bin->content !=3D DNS_PAYLOAD_IS_SERVER_LIST) {
+		v1 =3D (const struct dns_server_list_v1_header *)data;
+		kenter("[%u,%u],%u", v1->hdr.content, v1->hdr.version, datalen);
+		if (v1->hdr.content !=3D DNS_PAYLOAD_IS_SERVER_LIST) {
 			pr_warn_ratelimited(
 				"dns_resolver: Unsupported content type (%u)\n",
-				bin->content);
+				v1->hdr.content);
 			return -EINVAL;
 		}
 =

-		if (bin->version !=3D 1) {
+		if (v1->hdr.version !=3D 1) {
 			pr_warn_ratelimited(
 				"dns_resolver: Unsupported server list version (%u)\n",
-				bin->version);
+				v1->hdr.version);
 			return -EINVAL;
 		}
 =

-		v1 =3D (const struct dns_server_list_v1_header *)bin;
 		if ((v1->status !=3D DNS_LOOKUP_GOOD &&
 		     v1->status !=3D DNS_LOOKUP_GOOD_WITH_BAD)) {
 			if (prep->expiry =3D=3D TIME64_MAX)


