Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E6C7B151F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjI1HjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjI1HjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:39:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B413AC;
        Thu, 28 Sep 2023 00:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695886739; x=1727422739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=40nXyAPgocdeKIF3kA25jghB0Z6YVlYWl0z9fcbH7IA=;
  b=J1a9FlampS2PPq+hvytNIZ96u+ToAmAyTNZTQG6c9F6Qw1ejwR/eCrbQ
   Rx0GSZdG8zPHUixnh8D99G1Up4OlDHOYP+8/1WBg9//ix18J0jQfxvhcI
   qc2O1hPVVbTJCbCi5JQKGpaH7WjZRqI7athbWNgwrAxPkuIW1B0Z3/v1s
   FKhnZ5z2Z5w5Dn+MvuwZ2IpXegWi2l4DRQ5CiSmVUzLWZ/oe++VgO3Bn3
   Aucj3LeKkmvJJIuhMCPVNG3PdCvdwsL6CLXuRiTRyPqbqIJ4iH3/hNfx1
   boaom9OTITLCJm3KageGpMnDtkMQoS4X3iLkT1TZ0OGG3hLB5aJTxFnHQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="367064857"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="367064857"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 00:38:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="742990418"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="742990418"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga007.jf.intel.com with ESMTP; 28 Sep 2023 00:38:57 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, x86@kernel.org, chang.seok.bae@intel.com
Subject: [PATCH v2 0/3] crypto: x86/aesni - Improve XTS data type
Date:   Thu, 28 Sep 2023 00:25:05 -0700
Message-Id: <20230928072508.218368-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925151752.162449-1-chang.seok.bae@intel.com>
References: <20230925151752.162449-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1->V2:
* Drop the unnecessary casts (Eric).
* Put the 'Link:' tag right after 'Suggested-by' (Eric).

---

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

