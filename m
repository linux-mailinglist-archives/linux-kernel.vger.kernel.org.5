Return-Path: <linux-kernel+bounces-155209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 729E58AE6D1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137361F214B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE0F127E0B;
	Tue, 23 Apr 2024 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oK8PfJ/x"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69994129E95;
	Tue, 23 Apr 2024 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876375; cv=none; b=rzFXOVpBNGuSxvrodeKl6F9aW+2gGAvA1G1vJiMQZkYFuU2AqXxHN0BRljjk8nq81OVoA839Rr+samUmYaSnIfRiHJ4B0jmFNIP/i7CbhwwdWcRbwZ1ksMCgWsmLc3eUZ8sPtDdEdsvDzauSVXSLcb6Khw9vol2ooBMPeeoks+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876375; c=relaxed/simple;
	bh=uf4EuAH4BuWnJz364epyOFKLwWP5s6X7hUicAJuYTSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jHgyPQXF3YSR87CKUCNtWelRfWbkrpHaPe/exX5lYoPJZZNw8DSOscVj5d1Y2cLfAeOnLxfNkAQBakIT5S36rNUX/VSWU8cAnLPgOBQ8H9enw0TCKP9rTViMQclYzOz5XaP52p6zAvES8HJIvUsAV14Ze/g0smJfao7Ki3CMFvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oK8PfJ/x; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=YHvDh9MSlvAAsyJZm3hGqNEWp393dezjxKkBeAue+Lc=; b=oK8PfJ/xiT3y0h2vUm5st6RGQA
	2+pKXK7YgbgtOd8PFcwPgi0ehfYBFRj2+7d7C/WqtXVihdi4T5IRdgXNRO8yEild+RkIxWb5zpW6V
	OtX5zIDAJ80Ah8rlbcm8u3s9ZMM6AwErIWEs5thg9vVuY3gqkJd5p0jIe+ZC5TBtCrK5jJKk0BJv3
	cZuVeNuaKrenyqjMm7k0DF/xIFVFwLlARq9r5ph/HYGzVgZudpBf2yYkNIy2oFNP4Gjl1CpmWJ7lg
	2t1HkHBXBLOmdX+2OLfDJdPUh9uXXdDypeZh9eJtqVoA6OBlFYpxoIypa6VljGdYJ6sflC3hSONAJ
	VtmQAK1g==;
Received: from [2001:4bb8:188:6493:c70:4a89:bc61:2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzFXH-0000000HUJa-3wFj;
	Tue, 23 Apr 2024 12:46:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <christian@brauner.io>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: xfs fixups for the fop_flags conversion
Date: Tue, 23 Apr 2024 14:46:05 +0200
Message-Id: <20240423124608.537794-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series against Christian's vfs.misc branch fixes up pointless
harmless but pointless over-declaration of capabilities for XFS
directories.

Christian: the first patch would make sense to just fold into the
original fop_flags conversion if you're still rebasing the branch.

 xfs_file.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

