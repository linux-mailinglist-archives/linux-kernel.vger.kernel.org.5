Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C807EE47E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345151AbjKPPhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjKPPhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:37:50 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988A7101
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:37:46 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 6A1ED959;
        Thu, 16 Nov 2023 16:37:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1700149064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bkzeO8gkvG3GN5Jru5wi0sviViECPmp8r79pScMlnXM=;
        b=u8F9GLoZH065uTsUxer2VnZihysU1cVc4/vx45ynWexmbPvSWoWOGJwDaqrZsYSagoTsDM
        5E9OTULboi10+nmv1LI5mFSoYssfraMDRMJQgR2mEGoj5Ag94qYUCPTqDz/ot5C76mad6N
        IVJPd98EUJk12D44LAikF0MncbFP2LhrdXHPLsbAAQZD3cFDBkHzPBfA0pIOa+RBWXO2Pv
        HqCslLMNY56e/UIebUwo74eXBv3gbqDHRLp2zbflYHhQtGdB6tziWb9F1HeLF7Kni0ubZP
        IuZkSOPF9Uk08bq8gIRorgj5eop5MoW9oO8O9w7FYx1fnFINjlhZGiY+Cx8tbg==
MIME-Version: 1.0
Date:   Thu, 16 Nov 2023 16:37:44 +0100
From:   Michael Walle <michael@walle.cc>
To:     Mark Brown <broonie@kernel.org>
Cc:     AceLan Kao <acelan.kao@canonical.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mario Kicherer <dev@kicherer.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] spi: Replace -ENOTSUPP with -EOPNOTSUPP in op
 checking
In-Reply-To: <401df72f-9255-4da3-b97e-93d3f38d352c@sirena.org.uk>
References: <20231116024338.337304-1-acelan.kao@canonical.com>
 <401df72f-9255-4da3-b97e-93d3f38d352c@sirena.org.uk>
Message-ID: <6d8dc9dba73e0a6274e9f8d891b8fcb8@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> The purpose of this patch is to distinguish the "operation not 
>> support"
>> error from the generic "not support", so that drivers could better
>> handle different errors.
> 
> What is the intended distinction between the two?

The commit message is misleading. The intention is to replace
ENOTSUPP with EOPNOTUPP for two reasons:
  (1) checkpatch will complain about the use of ENOTSUPP and apparently
      should only be used with NFS
  (2) more importantly, spi-nor already uses EOPNOTSUPP, but calls to
      spi-mem might return ENOTSUPP. We'd like to unify this.

-michael

