Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBAE7AAE90
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjIVJo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjIVJof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:44:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4AAE57;
        Fri, 22 Sep 2023 02:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695375862; x=1726911862;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=XqXG2jgGiK6RcE5JTJCQMqr1wkSsKU5xrFxakZbujqo=;
  b=fb3dYfKzzVhgWX/qNtOCr+Rl4aO2zyU2I+H7xCOyHqyJqMlLBgkSU2VU
   F76aMZ7f6RJ3Zfj+il6OZBKWN8Jk/ELr2a5Zhxi+kpd+0vgV0g58FBlg5
   fhPmtoyZTsFSBPz19BCW8VAfzSWP4a5rJ7MCaHTVBCS3fpFqJ9LYgifWB
   B1RERTHD6e+OeDhTctRrLAfPHGbXJnlj+fxrDKF7EqtSwvalIIEIrEeZJ
   yb5g2/2XRBSHjqXSUQwEkY//qcqZyY7kXrUNq/97i8aNEVnLqcr9ogxt8
   ricwqXiO0EJ20PHSchVFwoh6rXw8q/4IrKX3z3d+HqaCJzWdVnAPs9SBD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="447268802"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="447268802"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 02:44:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="782578828"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="782578828"
Received: from aboreiko-mobl3.ger.corp.intel.com (HELO localhost) ([10.252.50.131])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 02:44:18 -0700
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
In-Reply-To: <CAGXv+5FvmwMW+bxJ9d_ULbOJA9qpd-vybn0VyE5iyQLHCET1=A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230914131058.2472260-1-jani.nikula@intel.com>
 <20230914155317.2511876-1-jani.nikula@intel.com>
 <CAGXv+5GJxEobJKKWuc_UN+Gf_z8g6eb6KWTz-L+RqtyLYKK3Jg@mail.gmail.com>
 <87cyyetohx.fsf@intel.com>
 <CAGXv+5FvmwMW+bxJ9d_ULbOJA9qpd-vybn0VyE5iyQLHCET1=A@mail.gmail.com>
Date:   Fri, 22 Sep 2023 12:44:15 +0300
Message-ID: <87o7huo840.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023, Chen-Yu Tsai <wenst@chromium.org> wrote:
> On Tue, Sep 19, 2023 at 7:02=E2=80=AFPM Jani Nikula <jani.nikula@intel.co=
m> wrote:
>>
>> On Fri, 15 Sep 2023, Chen-Yu Tsai <wenst@chromium.org> wrote:
>> > On Thu, Sep 14, 2023 at 11:53=E2=80=AFPM Jani Nikula <jani.nikula@inte=
l.com> wrote:
>> >>
>> >> The sads returned by drm_edid_to_sad() needs to be freed.
>> >>
>> >> Fixes: e71a8ebbe086 ("drm/mediatek: dp: Audio support for MT8195")
>> >> Cc: Guillaume Ranquet <granquet@baylibre.com>
>> >> Cc: Bo-Chen Chen <rex-bc.chen@mediatek.com>
>> >> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.c=
om>
>> >> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> >> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>> >> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>> >> Cc: Matthias Brugger <matthias.bgg@gmail.com>
>> >> Cc: dri-devel@lists.freedesktop.org
>> >> Cc: linux-mediatek@lists.infradead.org
>> >> Cc: linux-kernel@vger.kernel.org
>> >> Cc: linux-arm-kernel@lists.infradead.org
>> >> Cc: <stable@vger.kernel.org> # v6.1+
>> >> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>> >
>> > Looks correct to me.
>> >
>> > Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>>
>> Thanks for the reviews Chen-Yu and Guillaume. Will you push this to
>> drm-misc-next or shall I?
>
> Patches for the MediaTek drm driver go through their own separate tree,
> maintained by CK (Chun-Kuang).

Chun-Kuang, can you confirm picking up these two patches, please?

MAINTAINERS does not list a separate git repository for MediaTek drm
drivers, so I don't know where that would be. It should probably be
added to MAINTAINERS.

Thanks,
Jani.

>
> ChenYu

--=20
Jani Nikula, Intel
