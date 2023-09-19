Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73857A6082
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjISLCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjISLCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:02:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2163E3;
        Tue, 19 Sep 2023 04:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695121352; x=1726657352;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=uELnytT+CuvLOJY3ZLfkVdcq80klKvGzS1iwGb1zs7A=;
  b=i6P4oO+rfr4V3iRxa0OAAHKAiTmYDi/hRpijKgl9rmnyPZr14pJ0ybeK
   6jF+a/wswwiJT+h9wUCWB8msagty08WAdua2WwMX0Rio+YI+F90c8SDjw
   4UTchxUFLCs+vdWB9JFsDGL2GNzB3uVLHMS7dpPhHEL1EFuNbmwwvlxy5
   jUr2SfVhUT9et06QQT6rH08sxIIxkaee2XYxay0MJ8SREooMnAgWqGRT7
   jtk0Fslez2EcBAn/iSPNyKHCGW34N8UIU+EJG3KeUQ9OSIUQ8gCZQir6I
   0CTGvaAWG2QCywM0HqbKRhsYfLKfjWsdFVKdR9MHX2IZ8uc8+H36w4aLK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="370229175"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="370229175"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 04:02:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="919830091"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="919830091"
Received: from tjquresh-mobl.ger.corp.intel.com (HELO localhost) ([10.252.37.227])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 04:02:20 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Guillaume Ranquet <granquet@baylibre.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] drm/mediatek/dp: fix memory leak on ->get_edid callback
 audio detection
In-Reply-To: <CAGXv+5GJxEobJKKWuc_UN+Gf_z8g6eb6KWTz-L+RqtyLYKK3Jg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230914131058.2472260-1-jani.nikula@intel.com>
 <20230914155317.2511876-1-jani.nikula@intel.com>
 <CAGXv+5GJxEobJKKWuc_UN+Gf_z8g6eb6KWTz-L+RqtyLYKK3Jg@mail.gmail.com>
Date:   Tue, 19 Sep 2023 14:02:18 +0300
Message-ID: <87cyyetohx.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023, Chen-Yu Tsai <wenst@chromium.org> wrote:
> On Thu, Sep 14, 2023 at 11:53=E2=80=AFPM Jani Nikula <jani.nikula@intel.c=
om> wrote:
>>
>> The sads returned by drm_edid_to_sad() needs to be freed.
>>
>> Fixes: e71a8ebbe086 ("drm/mediatek: dp: Audio support for MT8195")
>> Cc: Guillaume Ranquet <granquet@baylibre.com>
>> Cc: Bo-Chen Chen <rex-bc.chen@mediatek.com>
>> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>> Cc: Matthias Brugger <matthias.bgg@gmail.com>
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: linux-mediatek@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: <stable@vger.kernel.org> # v6.1+
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> Looks correct to me.
>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Thanks for the reviews Chen-Yu and Guillaume. Will you push this to
drm-misc-next or shall I?

BR,
Jani.


--=20
Jani Nikula, Intel
