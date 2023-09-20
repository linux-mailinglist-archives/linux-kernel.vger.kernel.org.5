Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E04F7A827D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbjITM7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236090AbjITM70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:59:26 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:59:20 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38KCx5La045258;
        Wed, 20 Sep 2023 07:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695214745;
        bh=hdo+tzS4ia/0mO/1cuvpBQdoVnI6w8AOqdw1l9UCOHQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=le1AWPMJOqz4H0ioNw/BXhKgO2nA7DBzIc9KbWHJ+/AsjC5j/XoDMvfK8mDhtS5NU
         5HsEo+8gAxAOsBCmaFtu0vCkCiP0FbfijO0X/rRWxtGfgJW1VT9c3yljElAPT6DdTz
         1gjeLRY4LkDOvZo4VGHoG1xH9qU2+tKJjPWIuiIM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38KCx4kT006292
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Sep 2023 07:59:05 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Sep 2023 07:59:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Sep 2023 07:59:04 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38KCx47Y107533;
        Wed, 20 Sep 2023 07:59:04 -0500
Date:   Wed, 20 Sep 2023 07:59:04 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Dhruva Gole <d-gole@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u.kleine-koenig@pengutronix.de>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <vibhore@ti.com>
Subject: Re: [PATCH] firmware: ti_sci: Mark driver as non removable
Message-ID: <20230920125904.omqvmzr2xlxqcouu@bonfire>
References: <20230907171700.1922453-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230907171700.1922453-1-d-gole@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22:47-20230907, Dhruva Gole wrote:
> The TI-SCI message protocol provides a way to communicate between
> various compute processors with a central system controller entity. It
> provides the fundamental device management capability and clock control
> in the SOCs that it's used in.
> 
> Ensure that the driver isn't unbound by suppressing its bind and unbind
> sysfs attributes. As the driver is built-in there is no way to remove
> device once bound.
> 
> We can also remove the ti_sci_remove call along with the
> ti_sci_debugfs_destroy as there are no callers for it any longer.
> 
> Fixes: aa276781a64a ("firmware: Add basic support for TI System Control Interface (TI-SCI) protocol")
> Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>

Add Reported-by and Closes tags

Also please address the comment from Uwe on improving the commit message

[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
