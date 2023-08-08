Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A0877445F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbjHHSSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbjHHSRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:17:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA28812B3;
        Tue,  8 Aug 2023 10:24:58 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RKnKj4CQ5z687PR;
        Tue,  8 Aug 2023 17:03:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 10:07:25 +0100
Date:   Tue, 8 Aug 2023 10:07:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Wenhua Lin <Wenhua.Lin@unisoc.com>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Samuel Holland <samuel@sholland.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "Mattijs Korpershoek" <mkorpershoek@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        "Baolin Wang" <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH] input: keyboard: Add sprd-keypad driver
Message-ID: <20230808100721.00006775@Huawei.com>
In-Reply-To: <20230808072501.3393-1-Wenhua.Lin@unisoc.com>
References: <20230808072501.3393-1-Wenhua.Lin@unisoc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2023 15:25:01 +0800
Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:

> Add matrix keypad driver, support matrix keypad function.
> 

No idea why you cc'd me on this one, but I wanted some light reading whilst
having a coffee so here's a quick review :)

Hohum. Took me a bit long than planned. Ah well, I hope you find the
feedback useful.

> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>  drivers/input/keyboard/Kconfig       |  10 +
>  drivers/input/keyboard/Makefile      |   1 +
>  drivers/input/keyboard/sprd_keypad.c | 418 +++++++++++++++++++++++++++
>  3 files changed, 429 insertions(+)
>  create mode 100644 drivers/input/keyboard/sprd_keypad.c
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 1d0c5f4c0f99..f35d9bf05f72 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -809,4 +809,14 @@ config KEYBOARD_CYPRESS_SF
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called cypress-sf.
>  
> +config KEYBOARD_SPRD
> +	tristate "Spreadtrum keyboard support"
> +	depends on ARCH_SPRD || COMPILE_TEST
> +	select INPUT_MATRIXKMAP
> +	help
> +	  Keypad controller is used to interface a SoC with a matrix-keypad device,
> +	  The keypad controller supports multiple row and column lines.
> +	  Say Y if you want to use the SPRD keyboard.
> +	  Say M if you want to use the SPRD keyboard on SoC as module.
> +
>  endif
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index aecef00c5d09..b747112461b1 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -66,6 +66,7 @@ obj-$(CONFIG_KEYBOARD_STOWAWAY)		+= stowaway.o
>  obj-$(CONFIG_KEYBOARD_ST_KEYSCAN)	+= st-keyscan.o
>  obj-$(CONFIG_KEYBOARD_SUN4I_LRADC)	+= sun4i-lradc-keys.o
>  obj-$(CONFIG_KEYBOARD_SUNKBD)		+= sunkbd.o
> +obj-$(CONFIG_KEYBOARD_SPRD)		+= sprd_keypad.o
>  obj-$(CONFIG_KEYBOARD_TC3589X)		+= tc3589x-keypad.o
>  obj-$(CONFIG_KEYBOARD_TEGRA)		+= tegra-kbc.o
>  obj-$(CONFIG_KEYBOARD_TM2_TOUCHKEY)	+= tm2-touchkey.o
> diff --git a/drivers/input/keyboard/sprd_keypad.c b/drivers/input/keyboard/sprd_keypad.c
> new file mode 100644
> index 000000000000..5b88072831e8
> --- /dev/null
> +++ b/drivers/input/keyboard/sprd_keypad.c
> @@ -0,0 +1,418 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Spreadtrum Communications Inc.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/input/matrix_keypad.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/clk.h>
> +#include <linux/of.h>
> +#include <linux/input.h>

Some sort of order of headers would be good.
Alphabetical is a good choice, though maybe Dmitry prefers something else.

> +
> +#define SPRD_KPD_CTRL			0x0
> +#define SPRD_KPD_INT_EN			0x4
> +#define SPRD_KPD_INT_RAW_STATUS		0x8
> +#define SPRD_KPD_INT_MASK_STATUS	0xc
> +#define SPRD_KPD_INT_CLR		0x10
> +#define SPRD_KPD_POLARITY		0x18
> +#define SPRD_KPD_DEBOUNCE_CNT		0x1c
> +#define SPRD_KPD_LONG_KEY_CNT		0x20
> +#define SPRD_KPD_SLEEP_CNT		0x24
> +#define SPRD_KPD_CLK_DIV_CNT		0x28
> +#define SPRD_KPD_KEY_STATUS		0x2c
> +#define SPRD_KPD_SLEEP_STATUS		0x30
> +#define SPRD_KPD_DEBUG_STATUS1		0x34
> +#define SPRD_KPD_DEBUG_STATUS2		0x38
> +
> +#define SPRD_KPD_EN			BIT(0)
> +#define SPRD_KPD_SLEEP_EN		BIT(1)
> +#define SPRD_KPD_LONG_KEY_EN		BIT(2)
> +
> +#define SPRD_KPD_ROWS_MSK		GENMASK(23, 16)
> +#define SPRD_KPD_COLS_MSK		GENMASK(15, 8)
> +
> +#define SPRD_KPD_INT_ALL		GENMASK(11, 0)
> +#define SPRD_KPD_INT_DOWNUP		GENMASK(7, 0)
> +#define SPRD_KPD_INT_LONG		GENMASK(11, 8)
> +
> +#define SPRD_KPD_ROW_POLARITY		GENMASK(7, 0)
> +#define SPRD_KPD_COL_POLARITY		GENMASK(15, 8)
> +
> +#define SPRD_KPD_PRESS_INTX(X, V) \
> +	(((V) >> (X)) & GENMASK(0, 0))

Given how this is used as a boolean check, I think 
if (SPRD_KPD_PRESS_INTX(i, int_status))
is same as

if (int_status & BIT(i)) which id easier to read.

> +#define SPRD_KPD_RELEASE_INTX(X, V) \
> +	(((V) >> ((X) + 4)) & GENMASK(0, 0))
For this one I'd define a mask and use field get so the check

if (SPRD_KPD_RELEASE_INTX(i, int_status)) {

becomes

#define SPRD_KPD_RELEASE_INTX_MSK GENMASK(7, 4)

if (FIELD_GET(SPRD_KPD_RELEASE_INTX_MSK, int_status) & BIT(i));


> +#define SPRD_KPD_INTX_COL(X, V) \
> +	(((V) >> ((X) << 3)) & GENMASK(2, 0))
> +#define SPRD_KPD_INTX_ROW(X, V) \
> +	(((V) >> (((X) << 3) + 4)) & GENMASK(2, 0))

Ok, on this I'm struggling to work out what is actually happening.

Looks to be picking out an 8 bit field then masking with 3 bits.
X = 0..3 

So define the mask with a suitable name and provide a macro to extract
only the 8 bit field.  I would suggest using multiply as simpler.

Something along the lines of...

#define SPRD_KBD_INTX_COL_MSK GENMASK(2, 0)
#define SPRD_KBD_INTX_ROW_MSK GENMASK(6, 4)
static u8 sprd_kbd_intx_extract_entry(u32 key_input, int x)
{
	return key_input >> (x * 8);
}
(key_input >> (X * 8)) & GENMASK(2, 0)

So
col = SPRD_KPD_INTX_COL(i, key_status);
row = SPRD_KPD_INTX_ROW(i, key_status);
becomes

u8 entry = sprd_kbd_intx_extract_entry(key_input, i);
col = FIELD_GET(SPRD_KBD_INTX_COL_MSK, entry)
row = FIELD_GET(SPRD_KBD_INTX_ROW_MSK, entry);

which is easier to follow than above macros.
That of course assumes I correctly figured out what those macros
were doing.

This is a case where readability is better than short code.



> +#define SPRD_KPD_INTX_DOWN(X, V) \
> +	(((V) >> (((X) << 3) + 7)) & GENMASK(0, 0))
> +


> +
> +static u32 sprd_keypad_time_to_counter(u32 array_size, u32 time_ms)
> +{
> +	u32 value;
> +
> +	/*
> +	 * y(ms) = (x + 1) * array_size
> +	 *		/ (32.768 / (clk_div_num + 1))
> +	 * y means time in ms
> +	 * x means counter
> +	 * array_size equal to rows * columns
> +	 * clk_div_num is devider to keypad source clock

divider
Also good to say the maths here is inverting the equation given.

> +	 **/
> +	value = SPRD_KPD_RTC_HZ * time_ms;
> +	value = value / (1000 * array_size *
> +			(SPRD_DEF_DIV_CNT + 1));
> +	if (value >= 1)
> +		value -= 1;
Good to have a comment on why this last check.  Can it end up as
less than one.
> +
> +	return value;
> +}
> +
> +static int sprd_keypad_hw_init(struct sprd_keypad_data *data)
> +{
> +	u32 value;
> +
> +	writel_relaxed(SPRD_KPD_INT_ALL, data->base + SPRD_KPD_INT_CLR);
> +	writel_relaxed(SPRD_KPD_ROW_POLARITY | SPRD_KPD_COL_POLARITY,
> +			data->base + SPRD_KPD_POLARITY);
> +	writel_relaxed(SPRD_DEF_DIV_CNT, data->base + SPRD_KPD_CLK_DIV_CNT);
> +
> +	value = sprd_keypad_time_to_counter(data->num_rows * data->num_cols,
> +						SPRD_DEF_LONG_KEY_MS);
> +	writel_relaxed(value, data->base + SPRD_KPD_LONG_KEY_CNT);
> +
> +	value = sprd_keypad_time_to_counter(data->num_rows * data->num_cols,
> +						data->debounce_ms);
> +	writel_relaxed(value, data->base + SPRD_KPD_DEBOUNCE_CNT);
> +
> +	value = SPRD_KPD_INT_DOWNUP;
> +	if (data->capabilities & SPRD_CAP_LONG_KEY)
> +		value |= SPRD_KPD_INT_LONG;
> +	writel_relaxed(value, data->base + SPRD_KPD_INT_EN);
> +
> +	value = SPRD_KPD_RTC_HZ - 1;
> +	writel_relaxed(value, data->base + SPRD_KPD_SLEEP_CNT);
> +
> +	/* set enabled rows and columns */
> +	value = (((data->rows_en << SPRD_KPD_ROWS_SHIFT)
> +		| (data->cols_en << SPRD_KPD_COLS_SHIFT))
> +		& (SPRD_KPD_ROWS_MSK | SPRD_KPD_COLS_MSK))
> +		| SPRD_KPD_EN | SPRD_KPD_SLEEP_EN;
> +	if (data->capabilities & SPRD_CAP_LONG_KEY)
> +		value |= SPRD_KPD_LONG_KEY_EN;
> +	writel_relaxed(value, data->base + SPRD_KPD_CTRL);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused sprd_keypad_suspend(struct device *dev)

What Arnd said on this..

> +{
> +	struct sprd_keypad_data *data = dev_get_drvdata(dev);
> +
> +	if (!device_may_wakeup(dev))
> +		sprd_keypad_disable(data);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused sprd_keypad_resume(struct device *dev)
> +{
> +	struct sprd_keypad_data *data = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	if (!device_may_wakeup(dev)) {
> +		ret = sprd_keypad_enable(data);
> +		if (ret)
> +			return ret;
> +		ret = sprd_keypad_hw_init(data);
> +	}
> +
> +	return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(sprd_keypad_pm_ops,
> +			sprd_keypad_suspend, sprd_keypad_resume);
> +
> +static int sprd_keypad_parse_dt(struct device *dev)
> +{
> +	struct sprd_keypad_data *data = dev_get_drvdata(dev);
> +	struct device_node *np = dev->of_node;
> +	int ret;
> +
> +	ret = matrix_keypad_parse_properties(dev, &data->num_rows, &data->num_cols);
> +	if (ret)
> +		return ret;
> +
> +	if (data->num_rows > SPRD_KPD_ROWS_MAX
> +		|| data->num_cols > SPRD_KPD_COLS_MAX) {
> +		dev_err(dev, "invalid num_rows or num_cols\n");

This is only called from probe, so dev_err_probe() is appropriate throughout this
function.

> +		return -EINVAL;
> +	}
> +
> +	ret = of_property_read_u32(np, "debounce-interval", &data->debounce_ms);

Whilst it's probably unlikely another firmware will be used with this,
we have generic property accessors in linux/property.h that will work should anyone
ever do so and at no cost for this driver.

> +	if (ret) {
> +		data->debounce_ms = 5;
> +		dev_warn(dev, "parse debounce-interval failed.\n");
> +	}
> +
> +	if (of_get_property(np, "linux,repeat", NULL))

device_property_read_bool() calls the check on the property being present
so is both more general and more obvious than what you have here.


> +		data->capabilities |= SPRD_CAP_REPEAT;
> +	if (of_get_property(np, "sprd,support_long_key", NULL))
> +		data->capabilities |= SPRD_CAP_LONG_KEY;
> +	if (of_get_property(np, "wakeup-source", NULL))
> +		data->capabilities |= SPRD_CAP_WAKEUP;
> +
> +	data->enable = devm_clk_get(dev, "enable");

devm_clk_get_enabled() for both of these. 

> +	if (IS_ERR(data->enable)) {
> +		if (PTR_ERR(data->enable) != -EPROBE_DEFER)
> +			dev_err(dev, "get enable clk failed.\n");
> +		return PTR_ERR(data->enable);
> +	}
> +
> +	data->rtc = devm_clk_get(dev, "rtc");
> +	if (IS_ERR(data->rtc)) {
> +		if (PTR_ERR(data->enable) != -EPROBE_DEFER)
> +			dev_err(dev, "get rtc clk failed.\n");
> +		return PTR_ERR(data->rtc);
> +	}
> +
> +	return 0;
> +}
> +
> +static int sprd_keypad_probe(struct platform_device *pdev)
> +{
> +	struct sprd_keypad_data *data;
> +	struct resource *res;
> +	int ret, irq, i, j, row_shift;
> +	unsigned long rows, cols;
> +	unsigned short *keycodes;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->base = devm_ioremap_resource(&pdev->dev, res);

devm_platform_get_and_ioremap_resource)

> +	if (IS_ERR(data->base)) {
> +		dev_err(&pdev->dev, "ioremap resource failed.\n");
> +		ret =  PTR_ERR(data->base);
> +		goto err_free;

Read up on what devm calls do - there is no need to manually free
things that were allocated with them in the error paths or remove.
So this should be a direct return. Also use
		return dev_err_probe(&pdev->dev, PTR_ERR(data->base),
				     "....")

It both creates neater code and for cases where deferred probing
is possible you will get a nice message on 'why' registered for
debug purposes.


> +	}
> +
> +	platform_set_drvdata(pdev, data);
> +	ret = sprd_keypad_parse_dt(&pdev->dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "keypad parse dts failed.\n");
> +		goto err_free;

Direct return and dev_err_probe()

> +	}
> +
> +	data->input_dev = devm_input_allocate_device(&pdev->dev);
> +	if (IS_ERR(data->input_dev)) {
> +		dev_err(&pdev->dev, "alloc input dev failed.\n");
> +		ret =  PTR_ERR(data->input_dev);
> +		goto err_free;

Direct return, dev_err_probe() and what happened with the spacing?

> +	}
> +
> +	data->input_dev->name = "sprd-keypad";
> +	data->input_dev->phys = "sprd-key/input0";
> +
> +	ret = matrix_keypad_build_keymap(NULL, NULL, data->num_rows,
> +					 data->num_cols, NULL, data->input_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "keypad build keymap failed.\n");
> +		goto err_free;

As above.

> +	}
> +
> +	rows = cols = 0;
> +	row_shift = get_count_order(data->num_cols);
> +	keycodes = data->input_dev->keycode;
> +	for (i = 0; i < data->num_rows; i++) {
> +		for (j = 0; j < data->num_cols; j++) {
> +			if (!!keycodes[MATRIX_SCAN_CODE(i, j, row_shift)]) {

The !! is pointless if using it as a boolean.  No need to first convert it
to 0/1   0 is false anything else is true.

> +				set_bit(i, &rows);
> +				set_bit(j, &cols);
> +			}
> +		}
> +	}
> +	data->rows_en = rows;
> +	data->cols_en = cols;
> +
> +	if (data->capabilities & SPRD_CAP_REPEAT)
> +		set_bit(EV_REP, data->input_dev->evbit);
> +
> +	input_set_drvdata(data->input_dev, data);
> +
> +	ret = sprd_keypad_enable(data);
> +	if (ret) {
> +		dev_err(&pdev->dev, "keypad enable failed.\n");
> +		goto err_free;
Same again.

> +	}

I'd suggest a suitable callback and devm_add_action_or_reset()
to unwind the enable.

Actually seeing the code above, just call
devm_clk_get_enabled() here and drop the enable / disable functions.


> +
> +	ret = sprd_keypad_hw_init(data);
> +	if (ret) {
> +		dev_err(&pdev->dev, "keypad hw init failed.\n");
> +		goto clk_free;
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "platform get irq failed.\n");
> +		goto clk_free;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, irq, sprd_keypad_handler,
> +				IRQF_NO_SUSPEND, dev_name(&pdev->dev), pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "request irq failed.\n");
> +		goto clk_free;
> +	}
> +
> +	ret = input_register_device(data->input_dev);

Whilst there isn't a specific devm_ version of this, that is because there
doesn't need to be one.  Have a look at the implementation and how
it handles things when input_dev->devres_managed is set.

Upshot, you don't need to manually unwind this either.

> +	if (ret) {
> +		dev_err(&pdev->dev, "register input dev failed\n");
> +		goto clk_free;
> +	}
> +
> +	if (data->capabilities & SPRD_CAP_WAKEUP)
> +		device_init_wakeup(&pdev->dev, true);
Another devm_add_action_or_reset() use case.  Note: only register
the cleanup, if you use device_init_wakeup() here.

> +
> +	return 0;
> +
> +clk_free:
> +	sprd_keypad_disable(data);
> +err_free:
> +	devm_kfree(&pdev->dev, data);
With changes above, there will be no manual cleanup to do here.
> +	return ret;
> +}
> +
> +static int sprd_keypad_remove(struct platform_device *pdev)
> +{
> +	struct sprd_keypad_data *data = platform_get_drvdata(pdev);
> +	int irq = platform_get_irq(pdev, 0);
> +
> +	if (data->capabilities & SPRD_CAP_WAKEUP)
> +		device_init_wakeup(&pdev->dev, false);
> +
> +	input_unregister_device(data->input_dev);
> +	devm_free_irq(&pdev->dev, irq, pdev);

Calling a devm free is usually a bad sign and implies you shouldn't have used
devm to get the thing in the first place.
The two should not be mixed - so the moment you reach a call in probe() that
you don't want to use devm_ managed releases for, stop using them for everything
after that point.  There is devm_add_action_or_reset() though which can be used
to register your own cleanup functions and sometimes lets you take the whole
of the release flow device managed.

Suggestions above mean you will have no remove() function at all.


> +	sprd_keypad_disable(data);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sprd_keypad_match[] = {
> +	{ .compatible = "sprd,sc9860-keypad", },
> +	{},
> +};
> +
> +static struct platform_driver sprd_keypad_driver = {
> +	.driver = {
> +		.name = "sprd-keypad",
> +		.owner = THIS_MODULE,
> +		.of_match_table = sprd_keypad_match,
> +		.pm = &sprd_keypad_pm_ops,
> +	},
> +	.probe = sprd_keypad_probe,
> +	.remove = sprd_keypad_remove,
> +};
> +
> +module_platform_driver(sprd_keypad_driver);
> +
> +MODULE_DESCRIPTION("Spreadtrum KPD Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Neo Hou <neo.hou@unisoc.com>");

