Return-Path: <linux-kernel+bounces-71431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE1C85A529
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1201F23F67
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40DF374D4;
	Mon, 19 Feb 2024 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="p0g99vru"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0A1364C6;
	Mon, 19 Feb 2024 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708350783; cv=none; b=C3pvu0c51PWhWmMaA7ABQLKdQAOCyjHVkYV90bQtM+sLLy8jaAN/rOFhW/yga10qDC0ybm6jRh43okglpB+Mf1IB5IUUVLVC9HiykNoP0VS+I1INN7HXETafYEFstkMpcs7obaK0SMJuuOeZvPV+0nXC6/eir+J/HhxApQmhkuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708350783; c=relaxed/simple;
	bh=hyWFT+ulXsZ5bGq5VmS2PaTwAmRzWqlpSCcPDiLoFCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XrVZYisKWf8Ev2VogzpR8yAYKBL8r+ScTzDITTozbpeAYIfFJ2TsiEsIoznwGxLN+QQclNzavguReDwFDzVP+fRY/YSW+JMokFL3PEaUemDE38I2gvciPNloP0JaU96eL/VvwhT8DCYmSIoBXoh8ULuy4E3BEI0va2nmStUtz04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=p0g99vru; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 812242012153;
	Mon, 19 Feb 2024 14:52:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 812242012153
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708350779;
	bh=tt503T/pGpOcgK0THB0iW+sdLkagW2VxJB9yOA5ESYg=;
	h=From:To:Cc:Subject:Date:From;
	b=p0g99vru96y4+gufU78VYOpL1nxibj1MAFaoaGgs9OuPIwcF0Lx30DrfBGmgSPFEh
	 JpKac7wWxZ4ynmGL2mgkPMlbJcEApIDFqyOGLXo15cX/LSv9H/5+0QQn1y92PtQYP3
	 lf1Z/wf5gb/lVrWgV0vRDb6PAUU6oQOzoB1WQC6itcU9FLawvuBQ6jeT+HhKpvHrPr
	 t73bOoHweeOs0MB4QKYT2iVSmiMqR4Jp9C8D3nsvwfPTGL8y+KzFj1qVummG06duqp
	 fdtKVxLqznRXFuAztBnCLIJKbjCCsNaZSS3sazuWSc0dViK+AIvEJjTJaX6l0eZ5/s
	 Gwbn/8k8oi66A==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net v3 0/2] ioam6: fix write to cloned skb's
Date: Mon, 19 Feb 2024 14:52:53 +0100
Message-Id: <20240219135255.15429-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:
 - fix patches tag ("net" and version were removed unexpectedly)

v2:
 - use skb_ensure_writable() instead of skb_cloned()+pskb_expand_head()
 - refresh network header pointer in ip6_parse_tlv() when returning from
   ipv6_hop_ioam()

Make sure the IOAM data insertion is not applied on cloned skb's. As a
consequence, ioam selftests needed a refactoring.

Justin Iurman (2):
  Fix write to cloned skb in ipv6_hop_ioam()
  selftests: ioam: refactoring to align with the fix

 net/ipv6/exthdrs.c                         | 10 +++
 tools/testing/selftests/net/ioam6.sh       | 38 ++++-----
 tools/testing/selftests/net/ioam6_parser.c | 95 +++++++++++-----------
 3 files changed, 76 insertions(+), 67 deletions(-)


base-commit: 166c2c8a6a4dc2e4ceba9e10cfe81c3e469e3210
-- 
2.34.1


