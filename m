Return-Path: <linux-kernel+bounces-25330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C45D82CDAB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 17:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB4A2840E4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C3B259B;
	Sat, 13 Jan 2024 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzeDlIlN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D0D23A3;
	Sat, 13 Jan 2024 16:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A6DC433C7;
	Sat, 13 Jan 2024 16:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705162356;
	bh=eY95pKDSwPCysfQFtuD/fm3VNTUEsCIc1mpxmygQB10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tzeDlIlNfJa8TQ95vE2R1HS39Jw+d/eVRbp1D6g5t0S2zeQ9a1UiUOOvZ5J7CemBO
	 R8vyOKfcCovYEt4SqxW+9Qy9P0uTJD1dEfCQVzuuDYiA87BncBoqMQoLkk6BZZfNp6
	 IrS7qAxeJhyCHCA0ZXrxiv5K1tjUaUHopnV464HkmYyG4CJ6u8JF7rAK7b2OzSswcp
	 aO8OjTxKvq2rOTQe1czBLHlVFZQ6xeSxY3kmozdoeLVo0+XXdiixfLjm6uvjLtIc0N
	 aKINNN36DhlJG/87O1xE1oH3OV5ukaWk7dziZNJ5CWD3kWZB3y2OvGkDunfB6Fsuds
	 Ns32p9/Ck/Piw==
Date: Sat, 13 Jan 2024 16:12:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: test: test gain-time-scale helpers
Message-ID: <20240113161229.48d63b54@jic23-huawei>
In-Reply-To: <6b839dd533fd93b75c2e6f6a8f2286233d4901fb.1704881096.git.mazziesaccount@gmail.com>
References: <cover.1704881096.git.mazziesaccount@gmail.com>
	<6b839dd533fd93b75c2e6f6a8f2286233d4901fb.1704881096.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jan 2024 12:12:55 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Some light sensors can adjust both the HW-gain and integration time.
> There are cases where adjusting the integration time has similar impact
> to the scale of the reported values as gain setting has.
> 
> IIO users do typically expect to handle scale by a single writable 'scale'
> entry. Driver should then adjust the gain/time accordingly.
> 
> It however is difficult for a driver to know whether it should change
> gain or integration time to meet the requested scale. Usually it is
> preferred to have longer integration time which usually improves
> accuracy, but there may be use-cases where long measurement times can be
> an issue. Thus it can be preferable to allow also changing the
> integration time - but mitigate the scale impact by also changing the gain
> underneath. Eg, if integration time change doubles the measured values,
> the driver can reduce the HW-gain to half.
> 
> The theory of the computations of gain-time-scale is simple. However,
> some people (undersigned) got that implemented wrong for more than once.
> Hence some gain-time-scale helpers were introduced.
> 
> Add some simple tests to verify the most hairy functions.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
Hi Matti,

All seems reasonable to me. Some trivial formatting things inline
+ I'm not planning to check the maths as you are the expert in all of
this so I'll just trust you!

Also if this fails you get to pick up the pieces :)

Jonathan

>  CFLAGS_iio-test-format.o += $(DISABLE_STRUCTLEAK_PLUGIN)
> diff --git a/drivers/iio/test/iio-test-gts.c b/drivers/iio/test/iio-test-gts.c
> new file mode 100644
> index 000000000000..4d5271b0c7bc
> --- /dev/null
> +++ b/drivers/iio/test/iio-test-gts.c
> @@ -0,0 +1,517 @@
..

> +
> +static void test_iio_find_closest_gain_low(struct kunit *test)
> +{
> +	struct device *dev;
> +	bool in_range;
> +	int ret;
> +
> +	const struct iio_gain_sel_pair gts_test_gains_gain_low[] = {
> +		GAIN_SCALE_GAIN(4, TEST_GSEL_4),
> +		GAIN_SCALE_GAIN(16, TEST_GSEL_16),
> +		GAIN_SCALE_GAIN(32, TEST_GSEL_32),
> +	};
> +
> +	dev = test_init_iio_gain_scale(test, &gts);
> +	if (!dev)
> +		return;
> +
> +	ret = iio_find_closest_gain_low(&gts, 2, &in_range);
> +	KUNIT_EXPECT_EQ(test, 1, ret);
> +	KUNIT_EXPECT_EQ(test, true, in_range);
> +
> +	ret = iio_find_closest_gain_low(&gts, 1, &in_range);
> +	KUNIT_EXPECT_EQ(test, 1, ret);
> +	KUNIT_EXPECT_EQ(test, true, in_range);
> +
> +	ret = iio_find_closest_gain_low(&gts, 4095, &in_range);
> +	KUNIT_EXPECT_EQ(test, 2048, ret);
> +	KUNIT_EXPECT_EQ(test, true, in_range);
> +
> +	ret = iio_find_closest_gain_low(&gts, 4097, &in_range);
> +	KUNIT_EXPECT_EQ(test, 4096, ret);
> +	KUNIT_EXPECT_EQ(test, false, in_range);
> +
> +	kunit_device_unregister(test, dev);
> +
> +	dev = __test_init_iio_gain_scale(test, &gts, gts_test_gains_gain_low,
> +				ARRAY_SIZE(gts_test_gains_gain_low),
> +				gts_test_itimes, ARRAY_SIZE(gts_test_itimes));
> +	if (!dev)
> +		return;
> +
> +	ret = iio_find_closest_gain_low(&gts, 3, &in_range);
> +	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
> +	KUNIT_EXPECT_EQ(test, false, in_range);
> +
As below.

> +}
> +
> +static void test_iio_gts_total_gain_to_scale(struct kunit *test)
> +{
> +	struct device *dev;
> +	int ret, scale_int, scale_nano;
> +
> +	dev = test_init_iio_gain_scale(test, &gts);
> +	if (!dev)
> +		return;
> +
> +	ret = iio_gts_total_gain_to_scale(&gts, 1, &scale_int, &scale_nano);
> +	KUNIT_EXPECT_EQ(test, 0, ret);
> +	KUNIT_EXPECT_EQ(test, TEST_SCALE_1X, scale_int);
> +	KUNIT_EXPECT_EQ(test, 0, scale_nano);
> +
> +	ret = iio_gts_total_gain_to_scale(&gts, 1, &scale_int, &scale_nano);
> +	KUNIT_EXPECT_EQ(test, 0, ret);
> +	KUNIT_EXPECT_EQ(test, TEST_SCALE_1X, scale_int);
> +	KUNIT_EXPECT_EQ(test, 0, scale_nano);
> +
> +	ret = iio_gts_total_gain_to_scale(&gts, 4096 * 8, &scale_int,
> +					  &scale_nano);
> +	KUNIT_EXPECT_EQ(test, 0, ret);
> +	KUNIT_EXPECT_EQ(test, 0, scale_int);
> +	KUNIT_EXPECT_EQ(test, TEST_SCALE_NANO_4096X8, scale_nano);
> +
No need for a blank line here.

> +}
> +

> +static void test_iio_gts_chk_scales_all(struct kunit *test, struct iio_gts *gts,
> +					const int *vals, int len)
> +{
> +	static const int gains[] = {1, 2, 4, 8, 16, 32, 64, 128, 256, 512,
> +				    1024, 2048, 4096, 4096 * 2, 4096 * 4,
> +				    4096 * 8};
> +
> +	int expected[ARRAY_SIZE(gains) * 2];
> +	int i, ret;
> +	int exp_len = ARRAY_SIZE(gains) * 2;

Use this for expected[*] just above?

> +
> +	KUNIT_EXPECT_EQ(test, exp_len, len);
> +	if (len != exp_len)
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(gains); i++) {
> +		ret = iio_gts_total_gain_to_scale(gts, gains[i],
> +						  &expected[2 * i],
> +						  &expected[2 * i + 1]);
> +		KUNIT_EXPECT_EQ(test, 0, ret);
> +		if (ret)
> +			return;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(expected); i++)
> +		KUNIT_EXPECT_EQ(test, expected[i], vals[i]);
> +}

> +
> +static void test_iio_gts_avail_test(struct kunit *test)
> +{
> +	struct device *dev;
> +	int ret;
> +	int type, len;
> +	const int *vals;
> +
> +	dev = test_init_iio_gain_scale(test, &gts);
> +	if (!dev)
> +		return;
> +
> +	/* test table building for times and iio_gts_avail_times() */
> +	ret = iio_gts_avail_times(&gts, &vals, &type, &len);
> +	KUNIT_EXPECT_EQ(test, IIO_AVAIL_LIST, ret);
> +	if (ret)
> +		return;
> +
> +	KUNIT_EXPECT_EQ(test, IIO_VAL_INT_PLUS_MICRO, type);
> +	KUNIT_EXPECT_EQ(test, 8, len);
> +	if (len < 8)
> +		return;
> +
> +	test_iio_gts_chk_times(test, vals);
> +
> +	/* Test table building for all scales and iio_gts_all_avail_scales() */
> +	ret = iio_gts_all_avail_scales(&gts, &vals, &type, &len);
> +	KUNIT_EXPECT_EQ(test, IIO_AVAIL_LIST, ret);
> +	if (ret)
> +		return;
> +
> +	KUNIT_EXPECT_EQ(test, IIO_VAL_INT_PLUS_NANO, type);
> +
> +	test_iio_gts_chk_scales_all(test, &gts, vals, len);
> +
> +	/*
> +	 * Test table building for scales/time and
> +	 * iio_gts_avail_scales_for_time()
> +	 */
> +	ret = iio_gts_avail_scales_for_time(&gts, 200000, &vals, &type, &len);
> +	KUNIT_EXPECT_EQ(test, IIO_AVAIL_LIST, ret);
> +	if (ret)
> +		return;
> +
> +	KUNIT_EXPECT_EQ(test, IIO_VAL_INT_PLUS_NANO, type);
> +	test_iio_gts_chk_scales_t200(test, &gts, vals, len);
> +}
> +
> +static struct kunit_case iio_gts_test_cases[] = {
> +	KUNIT_CASE(test_init_iio_gts_invalid),
> +	KUNIT_CASE(test_iio_gts_find_gain_for_scale_using_time),
> +	KUNIT_CASE(test_iio_gts_find_new_gain_sel_by_old_gain_time),
> +	KUNIT_CASE(test_iio_find_closest_gain_low),
> +	KUNIT_CASE(test_iio_gts_total_gain_to_scale),
> +	KUNIT_CASE(test_iio_gts_avail_test),
> +	{}
> +};
> +
> +static struct kunit_suite iio_gts_test_suite = {
> +	.name = "iio-gain-time-scale",
> +	.test_cases = iio_gts_test_cases,
> +};
> +
> +kunit_test_suite(iio_gts_test_suite);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
> +MODULE_DESCRIPTION("Test IIO light sensor gain-time-scale helpers");
> +MODULE_IMPORT_NS(IIO_GTS_HELPER);
> +
Looks like a bonus blank line at the end here.

Jonathan



