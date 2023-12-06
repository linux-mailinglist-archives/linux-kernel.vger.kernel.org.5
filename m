Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A6D80769A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378523AbjLFR3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjLFR3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:29:08 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B806135
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bbaa.fun;
        s=krwu2211; t=1701883743;
        bh=6L0aV80MpIMQg2v5Xc3R+ZHBxuMW5G2CI33EecTOYII=;
        h=Message-ID:Date:MIME-Version:From:Subject:To;
        b=mP28PRvKGwNvAJYY5rYxXAcoFA4AwMwyV2iriDMU0jLIntBFm60kqC4/jz53iTBCp
         lxceN4PYca35v0bDFfVm7aGFY2t+P+OaqlLQuxTYUX/jz4nAWo1DLrYSYfYMJvOM4r
         KMk3exHlbSU5LDUMpjeTSdO7Bua9rLD4dNyUnaHg=
X-QQ-mid: bizesmtp77t1701883740ty5ph78u
Received: from [172.19.0.1] ( [180.136.64.83])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 07 Dec 2023 01:28:59 +0800 (CST)
X-QQ-SSF: 0100000000000020D000000A0000000
X-QQ-FEAT: drHCGgIjzJeRUGRdfbDjWYjjJBYARogEeTBTHHGihUsYAekWhZED4JBBNP9v7
        6FYxsRtjQahzqsOFd6dhrLkr9z5DPEGnrbYIlzksn3ZW709akCCPboOoshcCJuSCPsJCWsB
        ej1Fr2qP6eIrFYHNqN89LDmawoCxqsLaCSmjN/QH5VaPnyJRPH1PiReeEhEtFg5tcNh0hez
        x3y4zoAKCo/yMVW1dv5eO3aDTYz57/s/4fDUlnk0PeFnIBVOT3jx/K6IgGcOTRMGyu0jGYr
        8SVG+M3H7rgABYzEofoymxWPImH+D18aLZ38z627gZ+fhrUWuYQPKo7xAvEp1d+wNb02gmH
        KxnBgQDGcfDJe7VDbHjTdOLXP1NP26LpMqs7K/c
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12811341502959775276
Message-ID: <930E9B4C7D91FDFF+29b34d89-8658-4910-966a-c772f320ea03@bbaa.fun>
Date:   Thu, 7 Dec 2023 01:28:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   bbaa <bbaa@bbaa.fun>
Subject: [Bug Report] drm/edid: drm_edid_override_connector_update returns a
 incorrect value
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bbaa.fun:qybglogicsvrgz:qybglogicsvrgz5a-0
X-Spam-Status: Yes, score=6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FROM_SUSPICIOUS_NTLD,FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,RCVD_IN_XBL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        *      [43.155.65.254 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [43.155.65.254 listed in list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [43.155.65.254 listed in wl.mailspike.net]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 PDS_OTHER_BAD_TLD Untrustworthy TLDs
        *      [URI: bbaa.fun (fun)]
        *  0.0 SPF_NONE SPF: sender does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.0 FROM_SUSPICIOUS_NTLD_FP From abused NTLD
        *  0.5 FROM_SUSPICIOUS_NTLD From abused NTLD
        *  2.3 FORGED_MUA_MOZILLA Forged mail pretending to be from Mozilla
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

drm_edid_override_connector_update seem return a incorrect value.

drivers/gpu/drm/drm_edid.c (Linux 6.7-rc4)
   2294	/**
   2295	 * drm_edid_override_connector_update - add modes from override/firmware EDID
   2296	 * @connector: connector we're probing
   2297	 *
   2298	 * Add modes from the override/firmware EDID, if available. Only to be used from
   2299	 * drm_helper_probe_single_connector_modes() as a fallback for when DDC probe
   2300	 * failed during drm_get_edid() and caused the override/firmware EDID to be
   2301	 * skipped.
   2302	 *
   2303	 * Return: The number of modes added or 0 if we couldn't find any.
   2304	 */
   2305	int drm_edid_override_connector_update(struct drm_connector *connector)
   2306	{
   2307		const struct drm_edid *override;
   2308		int num_modes = 0;
   2309	
   2310		override = drm_edid_override_get(connector);
   2311		if (override) {
   2312			num_modes = drm_edid_connector_update(connector, override);
   2313	
   2314			drm_edid_free(override);
   2315	
   2316			drm_dbg_kms(connector->dev,
   2317				    "[CONNECTOR:%d:%s] adding %d modes via fallback override/firmware EDID\n",
   2318				    connector->base.id, connector->name, num_modes);
   2319		}
   2320	
   2321		return num_modes;
   2322	}
   2323	EXPORT_SYMBOL(drm_edid_override_connector_update);

The comment describes that it will return the number of modes added
However the function calls drm_edid_connector_update, will return 0 upon successful execution.

drivers/gpu/drm/drm_edid.c
   6813	/**
   6814	 * drm_edid_connector_update - Update connector information from EDID
   6815	 * @connector: Connector
   6816	 * @drm_edid: EDID
   6817	 *
   6818	 * Update the connector display info, ELD, HDR metadata, relevant properties,
   6819	 * etc. from the passed in EDID.
   6820	 *
   6821	 * If EDID is NULL, reset the information.
   6822	 *
   6823	 * Must be called before calling drm_edid_connector_add_modes().
   6824	 *
   6825	 * Return: 0 on success, negative error on errors.
   6826	 */
   6827	int drm_edid_connector_update(struct drm_connector *connector,
   6828				      const struct drm_edid *drm_edid)
   6829	{
   6830		update_display_info(connector, drm_edid);
   6831	
   6832		_drm_update_tile_info(connector, drm_edid);
   6833	
   6834		return _drm_edid_connector_property_update(connector, drm_edid);
   6835	}
   6836	EXPORT_SYMBOL(drm_edid_connector_update);

This will break the EDID override behavior on Nvidia graphics cards.

NVIDIA/open-gpu-kernel-modules:
kernel-open/nvidia-drm/nvidia-drm-connector.c:
   103  #if defined(NV_DRM_CONNECTOR_HAS_OVERRIDE_EDID)   104      if 
(connector->override_edid) {   105  #else   106      if 
(drm_edid_override_connector_update(connector) > 0) {   107  #endif 
   108          const struct drm_property_blob *edid = 
connector->edid_blob_ptr;   109 
drm_edid_override_connector_update(connector)  will return zero here.

regards,
bbaa



