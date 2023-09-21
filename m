Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C4B7AA285
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjIUVUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjIUVO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:14:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69AAA1520;
        Thu, 21 Sep 2023 10:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695319047; x=1726855047;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ocUYw9eVkqBv2VFvJPDH0psgHV0OVSpDbQGqlku3wz4=;
  b=WkQucGi8oEVndLZUd9yAq/IAMVl6Az2io+NQo5pn3l0PuEhYH7ZFbtvv
   NeTSmbkooEp5U4qfohYrAD5A34UGaRVlmD6E8UNFiR1YgY7Hkw+XMHuOa
   oVrObz0v6c65gS+ADTfQzKlZQrf7mDeVahzN7sQv4UoC+NglY3DAkH8R3
   McSJUJSJFu8/ohUmNa1FbKzg7SSRWzmfzARE+nOBdVdjymizD66YPaCQb
   gQcjVsUStpjKabYKH2qtI5MNfCOqfO9+8VT6IFH1ipbfEeYP2fk7s3c76
   6JxiEK3Lv94YrVVJ6JyFo8Zxbv/2qGFrPCgHZZKm7ZJbS4OWIvi0idXwf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="383203442"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="383203442"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:56:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723666415"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="723666415"
Received: from idubinov-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.52.72])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:56:11 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Pekka Paalanen <ppaalanen@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>,
        Sandy Huang <hjc@rock-chips.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-doc@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC v2 05/37] drm/connector: hdmi: Add output BPC to the
 connector state
In-Reply-To: <20230921114845.7edb1d37@eldfell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230920-kms-hdmi-connector-state-v2-0-17932daddd7d@kernel.org>
 <20230920-kms-hdmi-connector-state-v2-5-17932daddd7d@kernel.org>
 <20230921114845.7edb1d37@eldfell>
Date:   Thu, 21 Sep 2023 11:56:08 +0300
Message-ID: <87zg1fq507.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023, Pekka Paalanen <ppaalanen@gmail.com> wrote:
> On Wed, 20 Sep 2023 16:35:20 +0200
> Maxime Ripard <mripard@kernel.org> wrote:
>
>> We'll add automatic selection of the output BPC in a following patch,
>> but let's add it to the HDMI connector state already.
>> 
>> Signed-off-by: Maxime Ripard <mripard@kernel.org>
>> ---
>>  drivers/gpu/drm/drm_atomic.c              |  4 +++-
>>  drivers/gpu/drm/drm_atomic_state_helper.c |  6 +++++-
>>  drivers/gpu/drm/drm_connector.c           | 13 ++++++++++++-
>>  include/drm/drm_connector.h               | 13 ++++++++++++-
>>  4 files changed, 32 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
>> index b1b56dcaa76b..8dce0a2f2ac3 100644
>> --- a/drivers/gpu/drm/drm_atomic.c
>> +++ b/drivers/gpu/drm/drm_atomic.c
>> @@ -1143,9 +1143,11 @@ static void drm_atomic_connector_print_state(struct drm_printer *p,
>>  	drm_printf(p, "\tcolorspace=%s\n", drm_get_colorspace_name(state->colorspace));
>>  
>>  	if (connector->connector_type == DRM_MODE_CONNECTOR_HDMIA ||
>> -	    connector->connector_type == DRM_MODE_CONNECTOR_HDMIB)
>> +	    connector->connector_type == DRM_MODE_CONNECTOR_HDMIB) {
>>  		drm_printf(p, "\tbroadcast_rgb=%s\n",
>>  			   drm_hdmi_connector_get_broadcast_rgb_name(state->hdmi.broadcast_rgb));
>> +		drm_printf(p, "\toutput_bpc=%u\n", state->hdmi.output_bpc);
>> +	}
>>  
>>  	if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
>>  		if (state->writeback_job && state->writeback_job->fb)
>> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
>> index 0f7e5ba555b8..2c9b52ae1b56 100644
>> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
>> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
>> @@ -569,6 +569,9 @@ EXPORT_SYMBOL(drm_atomic_helper_connector_tv_reset);
>>  void __drm_atomic_helper_connector_hdmi_reset(struct drm_connector *connector,
>>  					      struct drm_connector_state *new_state)
>>  {
>> +	new_state->max_bpc = 8;
>> +	new_state->max_requested_bpc = 8;
>> +	new_state->hdmi.output_bpc = 8;
>
> Hi,
>
> will this be forcing all drivers using these helpers to default to max bpc = 8?
>
> I believe at least amdgpu would disagree. The defaults were changed in
> the recent years, IIRC to avoid extra modesets during boot-up when
> desktops prefer highest possible bpc for a mode.
>
> The 'max bpc' property itself is a manual workaround for faulty
> hardware that does not correctly indicate the max bpc it can handle. It
> should not default to be a limiting factor.
>
>>  	new_state->hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_AUTO;
>>  }
>>  EXPORT_SYMBOL(__drm_atomic_helper_connector_hdmi_reset);
>> @@ -651,7 +654,8 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
>>  	struct drm_connector_state *new_state =
>>  		drm_atomic_get_new_connector_state(state, connector);
>>  
>> -	if (old_state->hdmi.broadcast_rgb != new_state->hdmi.broadcast_rgb) {
>> +	if (old_state->hdmi.broadcast_rgb != new_state->hdmi.broadcast_rgb ||
>> +	    old_state->hdmi.output_bpc != new_state->hdmi.output_bpc) {
>>  		struct drm_crtc *crtc = new_state->crtc;
>>  		struct drm_crtc_state *crtc_state;
>>  
>> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
>> index b45471d540ac..f55f5918411c 100644
>> --- a/drivers/gpu/drm/drm_connector.c
>> +++ b/drivers/gpu/drm/drm_connector.c
>> @@ -459,6 +459,7 @@ EXPORT_SYMBOL(drmm_connector_init);
>>   * @funcs: callbacks for this connector
>>   * @connector_type: user visible type of the connector
>>   * @ddc: optional pointer to the associated ddc adapter
>> + * @max_bpc: Maximum bits per char the HDMI connector supports
>>   *
>>   * Initialises a preallocated HDMI connector. Connectors can be
>>   * subclassed as part of driver connector objects.
>> @@ -475,7 +476,8 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
>>  			     struct drm_connector *connector,
>>  			     const struct drm_connector_funcs *funcs,
>>  			     int connector_type,
>> -			     struct i2c_adapter *ddc)
>> +			     struct i2c_adapter *ddc,
>> +			     unsigned int max_bpc)
>>  {
>>  	int ret;
>>  
>> @@ -487,6 +489,15 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
>>  	if (ret)
>>  		return ret;
>>  
>> +	if (max_bpc) {
>> +		if (!(max_bpc == 8 || max_bpc == 10 || max_bpc == 12))
>> +			return -EINVAL;
>> +
>> +		drm_connector_attach_hdr_output_metadata_property(connector);
>> +		drm_connector_attach_max_bpc_property(connector, 8, max_bpc);
>> +		connector->max_bpc = max_bpc;
>> +	}
>> +
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL(drmm_connector_hdmi_init);
>> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
>> index fdcf64ab91a9..d0bcb835c857 100644
>> --- a/include/drm/drm_connector.h
>> +++ b/include/drm/drm_connector.h
>> @@ -1056,6 +1056,11 @@ struct drm_connector_state {
>>  		 * Broadcast RGB selection value.
>>  		 */
>>  		enum drm_hdmi_broadcast_rgb broadcast_rgb;
>> +
>> +		/**
>> +		 * @output_bpc: Bits per character to output.
>
> Is it not bits per channel?

Or component. Or color. Or color channel. ;)

But character I've never heard.


BR,
Jani.

>
>> +		 */
>> +		unsigned int output_bpc;
>>  	} hdmi;
>>  };
>>  
>> @@ -1700,6 +1705,11 @@ struct drm_connector {
>>  	 */
>>  	struct drm_property_blob *path_blob_ptr;
>>  
>> +	/**
>> +	 * @max_bpc: Maximum bits per character the connector supports.
>
> channel?
>
>> +	 */
>> +	unsigned int max_bpc;
>> +
>>  	/**
>>  	 * @max_bpc_property: Default connector property for the max bpc to be
>>  	 * driven out of the connector.
>> @@ -1939,7 +1949,8 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
>>  			     struct drm_connector *connector,
>>  			     const struct drm_connector_funcs *funcs,
>>  			     int connector_type,
>> -			     struct i2c_adapter *ddc);
>> +			     struct i2c_adapter *ddc,
>> +			     unsigned int max_bpc);
>>  void drm_connector_attach_edid_property(struct drm_connector *connector);
>>  int drm_connector_register(struct drm_connector *connector);
>>  void drm_connector_unregister(struct drm_connector *connector);
>> 
>
> Thanks,
> pq

-- 
Jani Nikula, Intel
