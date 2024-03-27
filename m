Return-Path: <linux-kernel+bounces-121417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE1388E7B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887FB1C2F8EC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8291448F8;
	Wed, 27 Mar 2024 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/V/bLQp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B57B12DD87;
	Wed, 27 Mar 2024 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549394; cv=none; b=tNR1mnB5efJhEYINpKinOzjiqNQLx8Kb08c3MtidyrlpNW9knVynAqFYIrwP97npf/JmfIWYk9vRfUfOHHdIvufpQIwJYPOhTw0snQRlSK6n0WMg3DrNkYXv5kOB2MuL04ZG1eIAMgUyCXe6JxpHYIE8L1BZ+ii1ZVfQEIZd2jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549394; c=relaxed/simple;
	bh=P4JbEcNYFbSu9LXCltDr+BrUszGs2RfxtXt7yDaOeNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d1nsV2bNvkI7qDBXYngP+sSNQpxvVYpMG2Rp7uTzIHYl5c6npVDGh99BZQW0FL1Rar8QGr0brE+inGabxvovBn03bJAZPjtzil6x9Ka7VWB1NVThEqS76NOjTdH5dX/tSI6VoG2U8h18CUME4P7ij+oLKkzvRATLPXO410gd6lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/V/bLQp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711549393; x=1743085393;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P4JbEcNYFbSu9LXCltDr+BrUszGs2RfxtXt7yDaOeNg=;
  b=G/V/bLQpgDAd3yv03Dj3Kb9zCP8kEQa9crcPavzLRXOB0YjK334jSC3Z
   p0s1pZFvwr/u8P54poY/T1vmnsqSw4CORfgn0dOqE4J9JQjTa0rQque1T
   W42ixS7ixAz60h+AGb4Otb4cekCPxS38kBtvQBpCMvaKaR8pb3y/NGOWB
   KLXcsJFTYER1R5I2n9xcKrwdoDm797g3jeZc9CvCAZRbxMC92sBt+xoPm
   KGJKD4D5qp7wy6p3dnksfmldP+H5dUp9nKpdEiZbYaWXmyUpvABQLKkeG
   dkoMAGOc7f9a4GgfHnhlnnxa9DjjCMWD1TgNgRu+ZqpSK/6ciL6RCkDNb
   g==;
X-CSE-ConnectionGUID: 7CZ7gxhqR9mgj/JeLA+rLA==
X-CSE-MsgGUID: GRQSzYNcRT60mt7c2HDWcw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6592519"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6592519"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 07:23:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="20973051"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 27 Mar 2024 07:23:10 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Simon Horman <horms@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/3] compiler_types: add Endianness-dependent __counted_by_{le,be}
Date: Wed, 27 Mar 2024 15:22:38 +0100
Message-ID: <20240327142241.1745989-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some structures contain flexible arrays at the end and the counter for
them, but the counter has explicit Endianness and thus __counted_by()
can't be used directly.

To increase test coverage for potential problems without breaking
anything, introduce __counted_by_{le,be} defined depending on platform's
Endianness to either __counted_by() when applicable or noop otherwise.
The first user will be virtchnl2.h from idpf just as example with 9 flex
structures having Little Endian counters.

Maybe it would be a good idea to introduce such attributes on compiler
level if possible, but for now let's stop on what we have.

Alexander Lobakin (3):
  compiler_types: add Endianness-dependent __counted_by_{le,be}
  idpf: make virtchnl2.h self-contained
  idpf: sprinkle __counted_by{,_le}() in the virtchnl2 header

 Documentation/conf.py                       |  2 ++
 scripts/kernel-doc                          |  1 +
 include/linux/compiler_types.h              | 11 ++++++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  2 ++
 drivers/net/ethernet/intel/idpf/virtchnl2.h | 24 ++++++++++-----------
 5 files changed, 28 insertions(+), 12 deletions(-)

---
From v1[0]:
* fix compilation of #2 (Jakub);
* pick Acked-bys (Gustavo).

From RFC[1]:

* teach kdoc new attributes (Simon, Kees);
* add Acked-by (Kees);
* fix a couple typos;
* send to net-next (Kees).

[0] https://lore.kernel.org/netdev/20240326164116.645718-1-aleksander.lobakin@intel.com
[1] https://lore.kernel.org/netdev/20240318130354.2713265-1-aleksander.lobakin@intel.com
-- 
2.44.0


