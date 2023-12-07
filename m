Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F05808600
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378777AbjLGJyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378695AbjLGJye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:54:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8794DD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701942881; x=1733478881;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=JVg+YFeylE5751j053diLSsB0HH6ZRmcj2hNvpngTOM=;
  b=GzRfHfffA8FvJ+pvSU2p1kDPkdBVovKmkQDYOoCj4Q10PJtXdWs9sPPI
   qDkIDwI+2lbFRPJgM6pQOItNO6wNZwT4r/Dfb24yRMGm5S4ZTSi72uPzl
   PRE0GQm3N1jkIKZbXiwiiiY2VL8JLrHRwSJdU8WHkSnyEvnhFjB2OwkkX
   cmHd4PakdjPS3n1qPvu49U30dQcA22EbvHv1B3WGe9wKoKCZJJn5+qrZ/
   xPHCLtNi1lwsNzvXC8I0BJTtE7hD8ssLq1i86okUuykpCSzMfW0sTsm9S
   l5IiJE5QKpecmJEPNB1nBm6WKDySMc1RsQgsjMkRkQrqBbviuy1r4/1op
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="12920383"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="12920383"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 01:54:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="895078971"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="895078971"
Received: from mrehana-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.62.169])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 01:54:36 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     bbaa <bbaa@bbaa.fun>, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [Bug Report] drm/edid: drm_edid_override_connector_update
 returns a incorrect value
In-Reply-To: <930E9B4C7D91FDFF+29b34d89-8658-4910-966a-c772f320ea03@bbaa.fun>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <930E9B4C7D91FDFF+29b34d89-8658-4910-966a-c772f320ea03@bbaa.fun>
Date:   Thu, 07 Dec 2023 11:54:34 +0200
Message-ID: <87jzpq1go5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Dec 2023, bbaa <bbaa@bbaa.fun> wrote:
> Hello everyone,
>
> drm_edid_override_connector_update seem return a incorrect value.
>
> drivers/gpu/drm/drm_edid.c (Linux 6.7-rc4)
>    2294	/**
>    2295	 * drm_edid_override_connector_update - add modes from override/f=
irmware EDID
>    2296	 * @connector: connector we're probing
>    2297	 *
>    2298	 * Add modes from the override/firmware EDID, if available. Only =
to be used from
>    2299	 * drm_helper_probe_single_connector_modes() as a fallback for wh=
en DDC probe
>    2300	 * failed during drm_get_edid() and caused the override/firmware =
EDID to be
>    2301	 * skipped.
>    2302	 *
>    2303	 * Return: The number of modes added or 0 if we couldn't find any.
>    2304	 */

Thanks for the report. I've sent a patch to hopefully fix this [1].

[1] https://patchwork.freedesktop.org/patch/msgid/20231207093821.2654267-1-=
jani.nikula@intel.com

However, please read the documentation comment above: "Only to be used
from drm_helper_probe_single_connector_modes() ..."

The function is a fallback for a *very* specific and rare scenario.

> This will break the EDID override behavior on Nvidia graphics cards.
>
> NVIDIA/open-gpu-kernel-modules:
> kernel-open/nvidia-drm/nvidia-drm-connector.c:
>  =C2=A0=C2=A0103 =C2=A0#if defined(NV_DRM_CONNECTOR_HAS_OVERRIDE_EDID) =
=C2=A0=C2=A0104 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=20
> (connector->override_edid) { =C2=A0=C2=A0105 =C2=A0#else =C2=A0=C2=A0106 =
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=20
> (drm_edid_override_connector_update(connector) > 0) { =C2=A0=C2=A0107 =C2=
=A0#endif=20
>  =C2=A0=C2=A0108 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0co=
nst struct drm_property_blob *edid =3D=20
> connector->edid_blob_ptr; =C2=A0=C2=A0109=20
> drm_edid_override_connector_update(connector)  will return zero here.

That's an out-of-tree driver that doesn't follow the documentation
above. Drivers have no business calling the function.

All of the override/firmware EDID handling should be covered
transparently via the drm_edid_read*() and drm_get_edid() functions, and
the drivers shouldn't have to ever care about overrides, at all. Drivers
shouldn't really use connector->edid_blob_ptr directly either.

Please report and get that fixed downstream.


BR,
Jani.


--=20
Jani Nikula, Intel
