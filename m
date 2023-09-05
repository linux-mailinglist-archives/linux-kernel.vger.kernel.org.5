Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1540792A80
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbjIEQi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353884AbjIEIaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:30:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9185CCB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 01:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693902575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I5qwaCnM8A6hekNnw5uw9hHW7jhIEIVhSWRsoqN1YfI=;
        b=RiWXTvAqPuTgo6QsnAaf+qvC7mX+rC8hRs5SltAo5rQyEBYfsAMW4nDtmlhUpSzut7Jmqu
        2CBcqEWTM6RFK33KNziyE7mLEEZm2tYMYmOoCZPlp9g4mZ2DOxoULw4fS0Y0LOpLOqgRqH
        rwmXwMTyjoeQCK2SYYVCPUHz92zcaaQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-vn0oRFxSOrmUEzgrn2VTWg-1; Tue, 05 Sep 2023 04:29:30 -0400
X-MC-Unique: vn0oRFxSOrmUEzgrn2VTWg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2126618DA720;
        Tue,  5 Sep 2023 08:29:30 +0000 (UTC)
Received: from localhost (unknown [10.72.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2245749310E;
        Tue,  5 Sep 2023 08:29:28 +0000 (UTC)
Date:   Tue, 5 Sep 2023 16:29:25 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, thunder.leizhen@huawei.com,
        dyoung@redhat.com, prudo@redhat.com, samuel.holland@sifive.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v2 3/8] crash_core: change parse_crashkernel() to support
 crashkernel=,high|low parsing
Message-ID: <ZPbm5SwHOhiAtG7w@MiWiFi-R3L-srv>
References: <20230829121610.138107-1-bhe@redhat.com>
 <20230829121610.138107-4-bhe@redhat.com>
 <c4a1f96e-2c8d-a496-61f3-0299d77c5c84@huaweicloud.com>
 <ZPGzlIkXqVThTwjg@MiWiFi-R3L-srv>
 <2b9af1b7-8d80-46b7-d582-156a97456a36@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b9af1b7-8d80-46b7-d582-156a97456a36@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/23 at 10:47am, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/9/1 17:49, Baoquan He wrote:
> >>> +
> >>> +		*high = true;
> >>> +	} else if (ret || !*crash_size) {
> >> This check can be moved outside of #ifdef. Because even '!high', it's completely
> >> applicable. The overall adjustment is as follows:
> > Hmm, the current logic is much easier to understand. However, I may not
> > 100% get your suggestion. Can you paste the complete code in your
> > suggested way? Do not need 100% correct code, just the skeleton of code logic
> > so that I can better understand it and add inline comment.
> 
> int __init parse_crashkernel(...)
> {
> 	int ret;
> 
> 	/* crashkernel=X[@offset] */
> 	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
> 				crash_base, NULL);
> 
> #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> 	if (high && ret == -ENOENT) {
> 		... ...		//The code for your original branch "else if (ret == -ENOENT) {"
> 		ret = 0;	//Added based on the next discussion
> 	}
> +#endif
> 
>  	if (!*crash_size)
> 		ret = -EINVAL;
> 
> 	return ret;
> }
> 
Thanks, Zhen Lei.

I paste the whole parse_crashkernel() as you suggested at bottom. Please
check if it's what you want. To me, both is fine to me. I have two minor
concerns to your suggested way.

1)
I took the "if (!high) return" way because except of x86/arm64, all
other architectures will call parse_crashkerne() and check
if *crash_size ==0. Please try 'git grep "parse_crashkernel(" arch'
and check those call sites. With that, we will have duplicated checking.

        ret = __parse_crashkernel(cmdline, system_ram, crash_size,
                                crash_base, NULL);
        if (!high)
                return ret;
2)
I actually like below branch and the code comment. It can give people
hint about what's going on in that case. Discarding it is a little pity.

        } else if (ret || !*crash_size) {
                /* The specified value is invalid */
                return -1;
        }

int __init parse_crashkernel(...)
{
	int ret;

	/* crashkernel=X[@offset] */
	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
				crash_base, NULL);
#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
	if (high && ret == -ENOENT) {
		ret = __parse_crashkernel(cmdline, 0, crash_size,
				crash_base, suffix_tbl[SUFFIX_HIGH]);
		if (ret || !*crash_size)
			return -EINVAL;

		/*
		 * crashkernel=Y,low can be specified or not, but invalid value
		 * is not allowed.
		 */
		ret = __parse_crashkernel(cmdline, 0, low_size,
				crash_base, suffix_tbl[SUFFIX_LOW]);
		if (ret == -ENOENT) {
			*low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
			ret = 0;
		} else if (ret) {
			return ret;
		}

		*high = true;
	}
#endif

	if (!*crash_size)
		ret = -EINVAL;

	return ret;
}

