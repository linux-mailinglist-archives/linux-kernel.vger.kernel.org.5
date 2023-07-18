Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B69A757FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjGROnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjGROn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:43:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C017172A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:43:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98E57615FB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C10AC433CA;
        Tue, 18 Jul 2023 14:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689691404;
        bh=w6bVSOVVCvV+Mgr+uiH/C+j6HhM8JjZmVwgHkfRzIWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R6i0a7rEZt3S1wzNlBgXdBulGDrNX1JARL5zcP3cg/fg8AqzNC6CSjpdHO6+npgS/
         HnvgS6BbAOiYABPLl90h7UIaF7nycBLTmIKhw4+hSjaDT9MXxuhiBQYoBs2Udx9sob
         cABFPM7UmpPxr86thinxvC97W4oUbpOgxaeEugAA=
Date:   Tue, 18 Jul 2023 16:43:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvmem: core: clear sysfs attributes for each NVMEM
 device
Message-ID: <2023071834-sixfold-reggae-0406@gregkh>
References: <ZLaZ03PzkbPNJQ3b@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLaZ03PzkbPNJQ3b@makrotopia.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 02:55:31PM +0100, Daniel Golle wrote:
> Set nvmem_cells_group.bin_attrs to NULL in case of an NVMEM device not
> having any cells in order to make sure sysfs attributes of a previously
> registered NVMEM device are not accidentally reused for a follow-up
> device which doesn't have any cells.

Wait, attributes and devices should NEVER be reused, how is that
happening here?

And just setting the attribute field to NULL doesn't free or clean up
anything, right?  Did memory just leak with this?

confused,

greg k-h
