Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1837CC836
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344260AbjJQPz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344299AbjJQPzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:55:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B40C9E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697558148; x=1729094148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PdRQtW1RsEyKvVD1SIpdj+V1KGBuViZmfbhU4YbcJbg=;
  b=mICm6X46asJHygzW5W2qvP3r+Fm3777bnbcLeyk3YlUdYYfTGKSpFGKA
   JzYbdoiWL23/tl/wFi6q2P+16SVz7/pxQR7xn+FbKj2CL7lppehd0u0o0
   0rF9bbsksPv0d9uTjPjq/pAeL07s9jO/bsvd4Wy/FuGz96tvpIJD+00sp
   xOWhS2QpQ+GN7fmkoYlp++xFAknp61lYGRGn8X3swhzDEgEXvQPf5bhtS
   LfJo4ATPH5+/E0QvS2NnAeeLzoswn0kulFGyDQtLRc58tIXtaSuCVlxzw
   x0lBHyw/d/CU0yLt8UlS+cTiEvNVlpgo55bCcJv5pXtcf07GfWTziczdg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="385651940"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="385651940"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 08:55:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="791271126"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="791271126"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Oct 2023 08:55:40 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsmPx-0009ln-2N;
        Tue, 17 Oct 2023 15:55:37 +0000
Date:   Tue, 17 Oct 2023 23:55:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, pierre-eric.pelloux-prayer@amd.com,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Pekka Paalanen <ppaalanen@gmail.com>, kernel-dev@igalia.com,
        alexander.deucher@amd.com, hwentlan@amd.com,
        christian.koenig@amd.com, joshua@froggi.es
Subject: Re: [PATCH v7 4/6] drm: Refuse to async flip with atomic prop changes
Message-ID: <202310172311.kgvIGcqy-lkp@intel.com>
References: <20231017092837.32428-5-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017092837.32428-5-andrealmeid@igalia.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi André,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm/drm-next linus/master v6.6-rc6 next-20231017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/drm-allow-DRM_MODE_PAGE_FLIP_ASYNC-for-atomic-commits/20231017-173047
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20231017092837.32428-5-andrealmeid%40igalia.com
patch subject: [PATCH v7 4/6] drm: Refuse to async flip with atomic prop changes
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231017/202310172311.kgvIGcqy-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310172311.kgvIGcqy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310172311.kgvIGcqy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/drm_atomic_uapi.c: In function 'drm_atomic_set_property':
>> drivers/gpu/drm/drm_atomic_uapi.c:1062:41: warning: unused variable 'config' [-Wunused-variable]
    1062 |                 struct drm_mode_config *config = &crtc->dev->mode_config;
         |                                         ^~~~~~


vim +/config +1062 drivers/gpu/drm/drm_atomic_uapi.c

  1021	
  1022	int drm_atomic_set_property(struct drm_atomic_state *state,
  1023				    struct drm_file *file_priv,
  1024				    struct drm_mode_object *obj,
  1025				    struct drm_property *prop,
  1026				    uint64_t prop_value,
  1027				    bool async_flip)
  1028	{
  1029		struct drm_mode_object *ref;
  1030		uint64_t old_val;
  1031		int ret;
  1032	
  1033		if (!drm_property_change_valid_get(prop, prop_value, &ref))
  1034			return -EINVAL;
  1035	
  1036		switch (obj->type) {
  1037		case DRM_MODE_OBJECT_CONNECTOR: {
  1038			struct drm_connector *connector = obj_to_connector(obj);
  1039			struct drm_connector_state *connector_state;
  1040	
  1041			connector_state = drm_atomic_get_connector_state(state, connector);
  1042			if (IS_ERR(connector_state)) {
  1043				ret = PTR_ERR(connector_state);
  1044				break;
  1045			}
  1046	
  1047			if (async_flip) {
  1048				ret = drm_atomic_connector_get_property(connector, connector_state,
  1049									prop, &old_val);
  1050				ret = drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
  1051				break;
  1052			}
  1053	
  1054			ret = drm_atomic_connector_set_property(connector,
  1055					connector_state, file_priv,
  1056					prop, prop_value);
  1057			break;
  1058		}
  1059		case DRM_MODE_OBJECT_CRTC: {
  1060			struct drm_crtc *crtc = obj_to_crtc(obj);
  1061			struct drm_crtc_state *crtc_state;
> 1062			struct drm_mode_config *config = &crtc->dev->mode_config;
  1063	
  1064			crtc_state = drm_atomic_get_crtc_state(state, crtc);
  1065			if (IS_ERR(crtc_state)) {
  1066				ret = PTR_ERR(crtc_state);
  1067				break;
  1068			}
  1069	
  1070			if (async_flip) {
  1071				ret = drm_atomic_crtc_get_property(crtc, crtc_state,
  1072								   prop, &old_val);
  1073				ret = drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
  1074				break;
  1075			}
  1076	
  1077			ret = drm_atomic_crtc_set_property(crtc,
  1078					crtc_state, prop, prop_value);
  1079			break;
  1080		}
  1081		case DRM_MODE_OBJECT_PLANE: {
  1082			struct drm_plane *plane = obj_to_plane(obj);
  1083			struct drm_plane_state *plane_state;
  1084			struct drm_mode_config *config = &plane->dev->mode_config;
  1085	
  1086			plane_state = drm_atomic_get_plane_state(state, plane);
  1087			if (IS_ERR(plane_state)) {
  1088				ret = PTR_ERR(plane_state);
  1089				break;
  1090			}
  1091	
  1092			if (async_flip && prop != config->prop_fb_id) {
  1093				ret = drm_atomic_plane_get_property(plane, plane_state,
  1094								    prop, &old_val);
  1095				ret = drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
  1096				break;
  1097			}
  1098	
  1099			ret = drm_atomic_plane_set_property(plane,
  1100					plane_state, file_priv,
  1101					prop, prop_value);
  1102			break;
  1103		}
  1104		default:
  1105			drm_dbg_atomic(prop->dev, "[OBJECT:%d] has no properties\n", obj->id);
  1106			ret = -EINVAL;
  1107			break;
  1108		}
  1109	
  1110		drm_property_change_valid_put(prop, ref);
  1111		return ret;
  1112	}
  1113	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
