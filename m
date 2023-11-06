Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C577E2A1F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjKFQlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjKFQlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:41:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C012C10FD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699288855; x=1730824855;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=W6TBX3wq5n6LG78ZXRmLyTkh51LstlH+EyHwK5EG/UU=;
  b=IPRVuF4lSBU/EodqejFw1cIt6lALlEgmAdvdm+ab9HhXklQuWqHBpF3R
   L12kgTJW9lfaXAc9XJOU8OruD9HCPyddxCU2Tc03M8rWAG7TCwBMsxyCH
   WQ6qGa937/HCkFEfQQ7hJCalxcc45HJausSGgkN3ylLhVOrJtRKQHSU1y
   yxNWIu4LEb6cnGHOQxxPoY2JM0CA0PiguVdMGQA3c7x2iALS7UKeDoA4b
   rS8i/PJ9yagkwCjECbnhkLTmtvCqr+EPNtM3kJJg6h9kFj4yZ3dVmK82K
   4S+u157SqLWH5rtfswGWjkdpO2+eoCMirD8SKdVHqTE+EWtWHyvOS2i8g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="453620461"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="453620461"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 08:40:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="10502671"
Received: from lpilolli-mobl.ger.corp.intel.com (HELO localhost) ([10.252.36.222])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 08:40:43 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: gpu: Fix warning using plain integer as NULL
In-Reply-To: <a2310260-ba15-428e-9fd1-08abb9565b18@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231103155013.332367-1-singhabhinav9051571833@gmail.com>
 <87sf5jyvkt.fsf@intel.com>
 <a2310260-ba15-428e-9fd1-08abb9565b18@gmail.com>
Date:   Mon, 06 Nov 2023 18:40:39 +0200
Message-ID: <87h6lyzvg8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2023, Abhinav Singh <singhabhinav9051571833@gmail.com> wrote:
> On 11/6/23 16:53, Jani Nikula wrote:
>> On Fri, 03 Nov 2023, Abhinav Singh <singhabhinav9051571833@gmail.com> wrote:
>>> sparse static analysis tools generate a warning with this message
>>> "Using plain integer as NULL pointer". In this case this warning is
>>> being shown because we are trying to intialize a pointer to NULL using
>>> integer value 0.
>>>
>>> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
>>> ---
>>>   drivers/gpu/drm/radeon/clearstate_evergreen.h | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/radeon/clearstate_evergreen.h b/drivers/gpu/drm/radeon/clearstate_evergreen.h
>>> index 63a1ffbb3ced..3b645558f133 100644
>>> --- a/drivers/gpu/drm/radeon/clearstate_evergreen.h
>>> +++ b/drivers/gpu/drm/radeon/clearstate_evergreen.h
>>> @@ -1049,7 +1049,7 @@ static const struct cs_extent_def SECT_CONTEXT_defs[] =
>>>       {SECT_CONTEXT_def_5, 0x0000a29e, 5 },
>>>       {SECT_CONTEXT_def_6, 0x0000a2a5, 56 },
>>>       {SECT_CONTEXT_def_7, 0x0000a2de, 290 },
>>> -    { 0, 0, 0 }
>>> +    { NULL, 0, 0 }
>> 
>> Random drive-by comment:
>> 
>> I'd just use {} as the sentinel.
>> 
>> BR,
>> Jani.
>> 
>>>   };
>>>   static const u32 SECT_CLEAR_def_1[] =
>>>   {
>>> @@ -1060,7 +1060,7 @@ static const u32 SECT_CLEAR_def_1[] =
>>>   static const struct cs_extent_def SECT_CLEAR_defs[] =
>>>   {
>>>       {SECT_CLEAR_def_1, 0x0000ffc0, 3 },
>>> -    { 0, 0, 0 }
>>> +    { NULL, 0, 0 }
>>>   };
>>>   static const u32 SECT_CTRLCONST_def_1[] =
>>>   {
>>> @@ -1070,11 +1070,11 @@ static const u32 SECT_CTRLCONST_def_1[] =
>>>   static const struct cs_extent_def SECT_CTRLCONST_defs[] =
>>>   {
>>>       {SECT_CTRLCONST_def_1, 0x0000f3fc, 2 },
>>> -    { 0, 0, 0 }
>>> +    { NULL, 0, 0 }
>>>   };
>>>   static const struct cs_section_def evergreen_cs_data[] = {
>>>       { SECT_CONTEXT_defs, SECT_CONTEXT },
>>>       { SECT_CLEAR_defs, SECT_CLEAR },
>>>       { SECT_CTRLCONST_defs, SECT_CTRLCONST },
>>> -    { 0, SECT_NONE }
>>> +    { NULL, SECT_NONE }
>>>   };
>>> --
>>> 2.39.2
>>>
>> 
> Hi, Thanks for dropping by and the suggestion. I thought of using NULL 
> instead of {} is because, first the warning itself says that 0 is used 
> to intialize pointers with NULL, and second due this link 
> https://www.spinics.net/lists/linux-sparse/msg10066.html where linus is 
> talking about not using 0 NULL intialization of pointer variable and he 
> thinks this is a legitimate issue and not some false positive

But... {} is neither of those things. It's empty initialization instead
of 0. It's valid in GCC and C23, and used all over the place in the
kernel.

BR,
Jani.



-- 
Jani Nikula, Intel
