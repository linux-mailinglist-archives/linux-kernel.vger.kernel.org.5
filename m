Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CA17F343B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbjKUQvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbjKUQuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:50:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E8D193;
        Tue, 21 Nov 2023 08:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700585452; x=1732121452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JTdRqF+yP9i6uEWuxlLEu23get1OZ+Y4sxPkDDh2+QM=;
  b=PespO3HB7JL+wDyKX122PAkIxmlafqGNF4L4j6G6RIAP1ZtEMPvYAGoD
   0C3Q/IsUXbzqB81RALyF/jPYnzOPjNsUO12kXukKAuWdJ7tqWjcfz7oUO
   oaFgdRgLijcfjDzJh6glF+1CImk6KO+wVQbYESrV8sVsGkp+9g76DKum4
   ytVHVvw31joVPIRCJS04rZxa860IoYQ7jATXkHYYNazhtl77UcsqkUuPP
   I3Tw225ECkeeFwsf3dYAhtmnPUGCQajHZHI6XH0MjC0XGK8rFsYCEl36z
   D8mzRiSSZDRx3b3cYJ5um3ky50lJWHyKmPQbURcCbme8CoZuSiexrVhsz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="13422930"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="13422930"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 08:50:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="795842221"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="795842221"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 21 Nov 2023 08:50:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A498513A; Tue, 21 Nov 2023 18:50:45 +0200 (EET)
Date:   Tue, 21 Nov 2023 18:50:45 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     andriy.shevchenko@linux.intel.com, rafael@kernel.org,
        lenb@kernel.org, robert.moore@intel.com, ardb@kernel.org,
        will@kernel.org, mark.rutland@arm.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v2 2/6] ACPI: bus: update acpi_dev_uid_match() to support
 multiple types
Message-ID: <20231121165045.GQ1074920@black.fi.intel.com>
References: <20231121103829.10027-1-raag.jadav@intel.com>
 <20231121103829.10027-3-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231121103829.10027-3-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 04:08:25PM +0530, Raag Jadav wrote:
> According to ACPI specification, a _UID object can evaluate to either
> a numeric value or a string. Update acpi_dev_uid_match() helper to
> support _UID matching for both integer and string types.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
