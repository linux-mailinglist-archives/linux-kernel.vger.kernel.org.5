Return-Path: <linux-kernel+bounces-74659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A3285D75C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6954B242E2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAE3481BD;
	Wed, 21 Feb 2024 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLVgCBmn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D769947A7C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516063; cv=none; b=SqG2ileM43eTKWnCA5BZZ9u5fANzSpgH+EcD3l3XJl7JS+yu4W2M3rNmQl5v8aGS+a14smlYFpNkYiqKs++L57qI6ppAAFQVXGMboTtLGH1UD0jojcfNhPx29S1EqvnyUNGRY3NH8N5rb8lB59MWyrfA81x0JfKMF+F7oMAXUGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516063; c=relaxed/simple;
	bh=H1opzQmLRRKn1Vlye2CjzNT5GlCrigionNIZr2eecsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JB7GKvmY/IqVIFF5ST9G6Py0XYtD+ML3/BP49iJi4EaufZr8lZf3cRF0pzcWCJRlKlSKpKz9af5uQ1OaoUc/ZZLTqJ9KcACSKL8BcnS9eUzf7VwPkAp9sXggxOPffC+Runq5NX4Jlah038ih10DKRraGByQYucWMOVP2sL7eDl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XLVgCBmn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708516048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vde4xB/Zz/mmmOpaSceLQiqhYFS5iO9FC1cBFRBuQi8=;
	b=XLVgCBmnBm0e2LB1Ne+DthMH4d36BS+ldkKoIQWc42qOwpBeYR9IwVYonjPmjykhLxg8jo
	H2quseURThIEpT8hIAMzvNazjMfqkI7wi9bzMURq1Bj7b4EBFUq/l72X4CuUqth2vhuM4J
	FYWpQI6oYapF8zyhiavOU2AL40H9Cgc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-Qm-29FoOP_uxIItQjYGr5g-1; Wed, 21 Feb 2024 06:47:24 -0500
X-MC-Unique: Qm-29FoOP_uxIItQjYGr5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C24C800074;
	Wed, 21 Feb 2024 11:47:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 51DAEC04254;
	Wed, 21 Feb 2024 11:47:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] mptcp: fix another deadlock issue
Date: Wed, 21 Feb 2024 12:46:57 +0100
Message-ID: <cover.1708515908.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Eric reported and diagnosed another possible deadlock problem with
the MPTCP diag code. The first patch address the issue, and the second
adds self-test coverage for the relevant codepath, to get lockdep help
to catch future similar issues.

Paolo Abeni (2):
  mptcp: fix possible deadlock in subflow diag
  selftests: mptcp: explicitly trigger the listener diag code-path

 net/mptcp/diag.c                          |  3 +++
 tools/testing/selftests/net/mptcp/diag.sh | 30 +++++++++++++++++++++++
 2 files changed, 33 insertions(+)

-- 
2.43.0


