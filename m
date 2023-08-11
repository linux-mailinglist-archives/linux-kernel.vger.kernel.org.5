Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6A6778A31
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbjHKJiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbjHKJib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:38:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9F83593;
        Fri, 11 Aug 2023 02:37:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D6A766D89;
        Fri, 11 Aug 2023 09:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07F3C433C7;
        Fri, 11 Aug 2023 09:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691746666;
        bh=jUB8VsZj4uee0oA780wgQ9ju7Cxe5ZCc6R6lPpXG4hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gGaDJWkA9t43Cexb+KYgyTgJiDvCgE1Id7EFhXI3HzKZs0GpVE9wiTt9BA8iNhPSJ
         l55/GiQ695LqiZeP1tNT6rJ9ggknUV8zGbNY/e2xH17g/nVK0azwJdJwZDBOGXFH0Y
         KhwmAVBkZOkKPvVzHm5gSiCBgJw72KKE/yzHc8i10Dg0/S1CTsRQjEoYu9XbmZxRRo
         FdTSkylp/bTEmqmNpoowILfi+y4gARSbBl5EkVAA26rS62IPLkvwEl4uIYgNR84rXf
         /KTOWP+E6W2xLn1/ICLAmNIjZc6DEfDTCjSJ59rM7PmSNL64ifD0L6ORPDANa0P/dg
         HRr5Wl/SxqqPg==
Date:   Fri, 11 Aug 2023 11:37:38 +0200
From:   Simon Horman <horms@kernel.org>
To:     Evan Quan <evan.quan@amd.com>
Cc:     rafael@kernel.org, lenb@kernel.org, Alexander.Deucher@amd.com,
        Christian.Koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        Mario.Limonciello@amd.com, mdaenzer@redhat.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        hdegoede@redhat.com, jingyuwang_vip@163.com, Lijo.Lazar@amd.com,
        jim.cromie@gmail.com, bellosilicio@gmail.com,
        andrealmeid@igalia.com, trix@redhat.com, jsg@jsg.id.au,
        arnd@arndb.de, andrew@lunn.ch, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH V8 2/9] drivers core: add ACPI based WBRF mechanism
 introduced by AMD
Message-ID: <ZNYBYuUSaio66vLN@vergenet.net>
References: <20230810073803.1643451-1-evan.quan@amd.com>
 <20230810073803.1643451-3-evan.quan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810073803.1643451-3-evan.quan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 03:37:56PM +0800, Evan Quan wrote:
> AMD has introduced an ACPI based mechanism to support WBRF for some
> platforms with AMD dGPU + WLAN. This needs support from BIOS equipped
> with necessary AML implementations and dGPU firmwares.
> 
> For those systems without the ACPI mechanism and developing solutions,
> user can use/fall-back the generic WBRF solution for diagnosing potential
> interference issues.
> 
> And for the platform which does not equip with the necessary AMD ACPI
> implementations but with CONFIG_WBRF_AMD_ACPI built as 'y', it will
> fall back to generic WBRF solution if the `wbrf` is set as "on".
> 
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Co-developed-by: Evan Quan <evan.quan@amd.com>
> Signed-off-by: Evan Quan <evan.quan@amd.com>

...

> diff --git a/drivers/acpi/amd_wbrf.c b/drivers/acpi/amd_wbrf.c

...

> +static bool check_acpi_wbrf(acpi_handle handle, u64 rev, u64 funcs)
> +{
> +	int i;
> +	u64 mask = 0;
> +	union acpi_object *obj;
> +
> +	if (funcs == 0)
> +		return false;
> +
> +	obj = acpi_evaluate_wbrf(handle, rev, 0);
> +	if (!obj)
> +		return false;
> +
> +	if (obj->type != ACPI_TYPE_BUFFER)
> +		return false;
> +
> +	/*
> +	 * Bit vector providing supported functions information.
> +	 * Each bit marks support for one specific function of the WBRF method.
> +	 */
> +	for (i = 0; i < obj->buffer.length && i < 8; i++)
> +		mask |= (((u64)obj->buffer.pointer[i]) << (i * 8));
> +
> +	ACPI_FREE(obj);
> +
> +	if ((mask & BIT(WBRF_ENABLED)) &&
> +	     (mask & funcs) == funcs)

Hi Evan,

a minor nit from my side: the indentation of the line above seems odd.

	if ((mask & BIT(WBRF_ENABLED)) &&
	    (mask & funcs) == funcs)

> +		return true;
> +
> +	return false;
> +}

...
