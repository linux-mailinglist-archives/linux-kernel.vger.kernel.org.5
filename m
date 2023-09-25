Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBD77ADB71
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjIYPbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjIYPby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:31:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468B395;
        Mon, 25 Sep 2023 08:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695655908; x=1727191908;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ohmo0uphE7YPdh5WwFbU8+KeksI6x6RafAzGQ1Oq1QM=;
  b=IgLsAW7H7m+4ZZPxHo+meX4GcowK2hqx+zUQUBzafrgVRxlMpceTQKfS
   KR3Dp/Upc5lpjdOpu5hdg/GGR6IOOJCpg81MZ7qEJYMUfq30ZWoThyK8O
   /gjpbOwou0gptwdfI1zRu/V04KJMqOACd2lyVluw3D7gTfXqpI//pxbcl
   zv5DPbKmSMCtbS9BZ2hfxpATwqKt0zU8XYAqz2oDUaxR7dPP3rANNUE0p
   NVzWTCt6s0WNv2BWH7SfKiB7RRyQG5aOVRZ/QY9N3bnb3UvpSon0Q0LZP
   oaZ14f7fU586so4YHrDB33cP93p2Wm68Lo9YTi+0cYjnYMw+p1lfN4Qr9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="361533581"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="361533581"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:31:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="725023003"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="725023003"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga006.jf.intel.com with ESMTP; 25 Sep 2023 08:31:45 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, x86@kernel.org, chang.seok.bae@intel.com
Subject: [PATCH 0/3] crypto: x86/aesni - Improve XTS data type
Date:   Mon, 25 Sep 2023 08:17:49 -0700
Message-Id: <20230925151752.162449-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field within the struct aesni_xts_ctx is currently defined as a
byte array, sized to match the struct crypto_aes_ctx. However, it
actually represents the struct data type.

To accurately redefine the data type, some adjustments have to be made
to the address alignment code. It involved refactoring the common
alignment code initially, followed by updating the structure's
definition. Finally, the XTS alignment is now performed early in the
process, rather than at every access point.

This change was suggested during Eric's review of another series
intended to enable an alternative AES implementation [1][2]. I viewed
it as an enhancement to the mainline, independent of the series.

I have divided these changes into incremental pieces, making them
considerably more reviewable and maintainable.

The series is based on the cryptodev's master branch:

    git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master

Thanks,
Chang

[1] https://lore.kernel.org/all/ZFWQ4sZEVu%2FLHq+Q@gmail.com/
[2] https://lore.kernel.org/all/20230526065414.GB875@sol.localdomain/

Chang S. Bae (3):
  crypto: x86/aesni - Refactor the common address alignment code
  crypto: x86/aesni - Correct the data type in struct aesni_xts_ctx
  crypto: x86/aesni - Perform address alignment early for XTS mode

 arch/x86/crypto/aesni-intel_glue.c | 52 ++++++++++++++----------------
 1 file changed, 25 insertions(+), 27 deletions(-)


base-commit: 1c43c0f1f84aa59dfc98ce66f0a67b2922aa7f9d
-- 
2.34.1

