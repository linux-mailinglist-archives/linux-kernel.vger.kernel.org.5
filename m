Return-Path: <linux-kernel+bounces-98383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD1D877944
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 01:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFE01F21997
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673A93BBE3;
	Mon, 11 Mar 2024 00:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iQmUVaA5"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BCA3B2A4
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710115234; cv=none; b=g+aucAJU5Uu3+iig8o/TJL01QPcNFiPyUDQxACS3p9CJtOgPBjcbyBIOTFkmtxIih4FQYhy3r0sKxz9Pj8/fdE1Qeb3p/soKK1Gp9rgtepv44GeINPwfnnvO3b1Ag4K85bckU/3hByPVP2LXmYGnq6umGg1H5LUm4TuabiVYPEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710115234; c=relaxed/simple;
	bh=+yDD08WUJWVj90tmydXaHQGrn6hOhO/u5npE/Lp3q2I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cvRAbOwHaaLLWW0VXh++q4NL3hHXKPMaSbqc1BU1ZhxUObqbnR56Ta8QGUFe0G2gfk0V0oEgbW2pv7lH7STDDXrduZaiORX9k4bm1wrtBs/HHWRmV5VnQfcgNARlu8ExLKUGdtN9iFuJvYQW6qkH30Rr5NaH+vNZLYf8lDSP1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iQmUVaA5; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 10 Mar 2024 20:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710115229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=+yDD08WUJWVj90tmydXaHQGrn6hOhO/u5npE/Lp3q2I=;
	b=iQmUVaA5ohFz+ZMs8pPQMoOCTX0Qv11lzykZvS5XyUdmk3IQP/bwVaIgBUkxyAD9dk8RQ3
	ZBlOKESPaaLntoG40kaJBC0j6hepv5gcqAkFxES7sX/DYaWviDNEoPZ/gimLkhqaL2lfsw
	TzXkE/FmJ2V1IAN/JkIxo2l0T+PoMIM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Guo Xuenan <guoxuenan@huawei.com>, Rajat Asthana <thisisrast7@gmail.com>, 
	Gao Xiang <xiang@kernel.org>, Nick Terrell <terrelln@fb.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: lz4 hc buffer overflow
Message-ID: <js2vmwcgwyx5kxq3csunc3piwkpfsebg3u2zewok6iis5wgn2e@eyy4fzryskj7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

reference https://github.com/koverstreet/bcachefs/issues/658

It looks like something is off with the bounds checking in LZ4 HC; I
haven't dug too deep yet. Never saw this with regular LZ4.

Anyone know anything? Are we missing a fix from the userspace library?

