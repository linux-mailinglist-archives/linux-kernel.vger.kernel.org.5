Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34147E80D3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345623AbjKJSSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346046AbjKJSQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:16:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7365FC3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:17:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C48C433CD;
        Fri, 10 Nov 2023 05:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699595869;
        bh=2/thsE8VetqAibMAzzhFVOgZBh0xwtrq6qPa9DCL+Eo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kTbaD2G9YsrVBFVDGQ5rvtAoCiaMYxJ65o2ddmy1z6WU4P1hLLyHeAJhcT/9SaCvE
         +VmAVvRFnODJ5K1d3f9EzcyqOeAWw/nemuUv0KOAwEQbNj7Gf7Az9rDZSiZj8mSCJP
         j+Wp6yxjw04YCqnT7rZAUWpHY//RKkZ4nGJUOh86uW0wlFHLJLSYRPGXyq5loxr+mp
         LsC58N26XCAW7gPkGAVi1RFc6vzLP22Dspbr+nE4qqq00g7i51AJ3VqRnEvxHNibXa
         d3lckb6SaSWvFzZPkdXcQTY32Lkr46scnonjHyv1ZWvSrabOaZnQoIqPPyIIfy2NbL
         gZ6cMxBEnF/zA==
Date:   Fri, 10 Nov 2023 13:57:46 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Kuan-Wei Chiu <visitorckw@gmail.com>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] platform/chrome: Implement quickselect for median
 calculation
Message-ID: <ZU3GWkKczNV-AQA4@google.com>
References: <20231109185439.1535962-1-visitorckw@gmail.com>
 <20231109185439.1535962-8-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109185439.1535962-8-visitorckw@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 02:54:39AM +0800, Kuan-Wei Chiu wrote:
>  /*
>   * cros_ec_sensor_ring_median: Gets median of an array of numbers
>   *
> - * For now it's implemented using an inefficient > O(n) sort then return
> - * the middle element. A more optimal method would be something like
> - * quickselect, but given that n = 64 we can probably live with it in the
> - * name of clarity.
> + * It's implemented using the quickselect algorithm, which achieves an
> + * average time complexity of O(n) the middle element. In the worst case,
> + * the runtime of quickselect could regress to O(n^2). To mitigate this,
> + * algorithms like median-of-medians exist, which can guarantee O(n) even
> + * in the worst case. However, these algorithms come with a higher
> + * overhead and are more complex to implement, making quickselect a
> + * pragmatic choice for our use case.

I am wondering if the patch helps given that n = 64.

>  static s64 cros_ec_sensor_ring_median(s64 *array, size_t length)
>  {
> -	sort(array, length, sizeof(s64), cros_ec_sensor_ring_median_cmp, NULL);
> -	return array[length / 2];
> +	const int k = length / 2;

`k` doesn't help readability.  Could you put `length / 2` to the code inline
or at least give it a better name.

> +	int lo = 0;
> +	int hi = length - 1;
> +
> +	while (lo <= hi) {
> +		int mid = lo + (hi - lo) / 2;
> +		int pivot, pivot_index;
> +		int i = lo - 1;

The be clear, I would prefer to initialize `i` when we really use it (i.e. at
the for-loop).

> +
> +		/* We employ the median-of-three rule to choose the pivot, mitigating

https://www.kernel.org/doc/html/latest/process/coding-style.html#commenting

> +		 * worst-case scenarios such as already sorted arrays and aiming to reduce
> +		 * the expected number of necessary comparisons. This strategy enhances the
> +		 * algorithm's performance and ensures a more balanced partitioning.
> +         */

$ ./scripts/checkpatch.pl --strict ...
ERROR: code indent should use tabs where possible
#284: FILE: drivers/platform/chrome/cros_ec_sensorhub_ring.c:171:
+         */$

> +		if (array[lo] > array[mid])
> +			cros_ec_sensor_ring_median_swap(&array[lo],
> +							&array[mid]);

It can fit into 100-column.

> +		if (array[lo] > array[hi])
> +			cros_ec_sensor_ring_median_swap(&array[lo], &array[hi]);
> +		if (array[mid] < array[hi])
> +			cros_ec_sensor_ring_median_swap(&array[mid],
> +							&array[hi]);

Ditto.

> +
> +		pivot = array[hi];
> +
> +		for (int j = lo; j < hi; j++)
> +			if (array[j] < pivot)
> +				cros_ec_sensor_ring_median_swap(&array[++i],
> +								&array[j]);

Ditto.

> +		cros_ec_sensor_ring_median_swap(&array[i + 1], &array[hi]);
> +		pivot_index = i + 1;
> +		if (pivot_index == k)
> +			return array[pivot_index];
> +		if (pivot_index > k)
> +			hi = pivot_index - 1;
> +		else
> +			lo = pivot_index + 1;

Add a comment and thus `pivot_index` can be eliminated.
