Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AD67A249F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbjIORY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbjIORYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:24:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19407E7F;
        Fri, 15 Sep 2023 10:24:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11D831FB;
        Fri, 15 Sep 2023 10:25:09 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97F533F5A1;
        Fri, 15 Sep 2023 10:24:29 -0700 (PDT)
Message-ID: <b47771d4-da62-b083-0ac6-b2f1f937c51d@arm.com>
Date:   Fri, 15 Sep 2023 18:24:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] pinctrl: rockchip: add support for io-domain
 dependency
Content-Language: en-GB
To:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Saravana Kannan <saravanak@google.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230904115816.1237684-1-s.hauer@pengutronix.de>
 <20230904115816.1237684-2-s.hauer@pengutronix.de>
 <CACRpkdYxRdToUM3JcEeNK_K87D5WDzzSLvVEbtqqdQEhz3k_Ow@mail.gmail.com>
 <CAGb2v65G-8EECNjqnpKCxqAD5nATAb0S7AA_WMiGXYOR1avrvg@mail.gmail.com>
 <20230913065843.GF637806@pengutronix.de>
 <CAGETcx8rO=aykjb6=5k0wpOyscqokNwSL6w-AHnodY7pNXyzGQ@mail.gmail.com>
 <20230915065120.GQ637806@pengutronix.de>
 <61e20eec-6d54-160e-abba-d668b1d19047@theobroma-systems.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <61e20eec-6d54-160e-abba-d668b1d19047@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 5:38 pm, Quentin Schulz wrote:
> Hi all,
> 
> On 9/15/23 08:51, Sascha Hauer wrote:
>> On Wed, Sep 13, 2023 at 01:48:12PM -0700, Saravana Kannan wrote:
>>> On Tue, Sep 12, 2023 at 11:58 PM Sascha Hauer 
>>> <s.hauer@pengutronix.de> wrote:
>>>>
>>>> On Wed, Sep 13, 2023 at 12:37:54PM +0800, Chen-Yu Tsai wrote:
>>>>> On Tue, Sep 12, 2023 at 4:07 PM Linus Walleij 
>>>>> <linus.walleij@linaro.org> wrote:
>>>>>>
>>>>>> Top posting to bring Saravana Kannan into this discussion.
>>>>>>
>>>>>> This looks like a big hack to me, Saravana has been working
>>>>>> tirelessly to make the device tree probe order "sort itself out"
>>>>>> and I am pretty sure this issue needs to be fixed at the DT
>>>>>> core level and not in a driver.
>>>>>
>>>>> We could merge all the IO domain stuff into the pinctrl node/driver,
>>>>> like is done for Allwinner? Maybe that would simplify things a bit?
>>>>
>>>> I thought about this as well. On Rockchip the pinctrl driver and the IO
>>>> domain driver even work on the same register space, so putting these
>>>> into a single node/driver would even feel more natural than what we 
>>>> have
>>>> now.
>>>
> 
> While technically not really wrong, I wouldn't say this is true either.
> 
> There's no real pinctrl IP address space on Rockchip SoCs (at least the 
> ones I worked on, so RK3399 and PX30), at least nothing delimited 
> properly. The typical pinctrl duties are scattered all over two (more 
> depending on the SoC maybe?) register address spaces, for PX30 and 
> RK3399 they are called GRF and PMUGRF. Many, MANY, IPs actually have 
> some registers to modify in those two register address spaces as well, 
> c.f. all the rockchip,grf and rockchip,pmu properties all over the place.
> 
> The pinctrl driver does refer those two register address spaces via the 
> aforementioned DT properties. Those two register address spaces are 
> represented as syscon... because if I remember correctly that's how you 
> are supposed to handle multiple devices on the same register address 
> space where registers or even register bitfields are mixed for different 
> IPs?
> 
> At the same time, IO domains also aren't in their own "real" address 
> space, similar as to how pinctrl is handled in HW.
> 
>>> Then we should try to do this and fix any issues blocking us.
>>>
>>>> However, with that the pinctrl node would get the supplies that the IO
>>>> domain node now has and we would never get into the probe of the 
>>>> pinctrl
>>>> driver due to the circular dependencies.
>>>
>>>  From a fw_devlink perspective, the circular dependency shouldn't be a
>>> problem. It's smart enough to recognize all cycle possibilities (since
>>> 6.3) and not enforce ordering between nodes in a cycle.
>>>
>>> So, this is really only a matter of pinctrl not trying to do
>>> regulator_get() in its probe function. You need to do the
>>> regulator_get() when the pins that depend on the io-domain are
>>> requested. And if the regulator isn't ready yet, return -EPROBE_DEFER?
>>
>> That's basically what my series does already, I return -EPROBE_DEFER
>> from the pinctrl driver when a pin is requested and the IO domain is not
>> yet ready.
>>
>>>
>>> Is there something that prevents us from doing that?
>>
>> No. We could do that, but it wouldn't buy us anthing. I am glad to hear
>> that fw_devlink can break the circular dependencies. With this we could
>> add the supplies to the pinctrl node and the pinctrl driver would still
>> be probed.
>>
>> With the IO domain supplies added to the pinctrl node our binding would
>> be cleaner, but still we would have to defer probe of many requested
>> pins until finally the I2C driver providing access to the PMIC comes
> 
> I don't think there's any way around the deferral "of many requested 
> pins until finally the I2C driver providing access to the PMIC comes 
> along", this is actually necessary.
> 
>> along. We also still need a "Do not defer probe for these pins" property
>> in the pingrp needed for the I2C driver.
>  >
> 
> Yes, this is the difficult part right now. In the RFC, I suggested to 
> have an io-domains property per pinmux DT node:
> 
> """
> &pinctrl {
>      group {
>          pinmux {
>               io-domains = <&io_domains>;
>               rockchip,pins = <0 RK_PA0 0 &pcfg_pull_none>,
>                           <3 RK_PB5 0 &pcfg_pull_none>;
>          };
>      };
> };
> """
> 
> But this is very tedious for both SoC maintainers (though they would 
> probably have to do it "only" once) AND for board maintainers, for each 
> new pinmux they require. Since the SoC maintainer cannot know on which 
> i2c (or spi?) bus the PMIC will be, they have two choices: either let 
> board maintainers not forget to add the io-domains property to the 
> i2c/spi pinmux nodes of all but the one to whcih the PMIC is attached, 
> or have the board maintainers add a /delete-property/ io-domains to the 
> proper i2c/spi pinmux node to which the PMIC is attached.
> 
> The first one is very error-prone, the second is not very liked by DT 
> people I think (and also... well is a hack on DT level to manage a 
> driver/subsystem issue).
> 
> Also on a side note, the current binding for the io-domains is a bit not 
> granular enough as it represents the collection of IO domains on the 
> same register address space, and you can have multiple ones. e.g. for 
> RK3399 you have four in "grf"/"normal" IO domain, which makes the 
> inter-dependencies unnecessarily complex (but that's probably tangent to 
> the current problem in discussion).
> 
>> I would consider this being a way to cleanup the bindings, but not a
>> solution at DT core level that Linus was aiming at.
>>
>>>
>>>>>
>>>>> IIRC on Allwinner SoCs the PMIC pins don't have a separate power rail,
>>>>> or if they do they almost certainly use the default I/O rail that is
>>>>> always on, and so we omit it to work around the dependency cycle.
>>>>
>>>> I looked into sun50i as an example. This one has two pinctrl nodes, pio
>>>> and r_pio. Only the former has supplies whereas the latter, where the
>>>> PMIC is connected to, has (found in sun50i-a64-pinephone.dtsi):
>>>>
>>>> &r_pio {
>>>>          /*
>>>>           * FIXME: We can't add that supply for now since it would
>>>>           * create a circular dependency between pinctrl, the regulator
>>>>           * and the RSB Bus.
>>>>           *
>>>>           * vcc-pl-supply = <&reg_aldo2>;
>>>>           */
>>>> };
>>>>
>>>> At least it show me that I am not the first one who has this problem ;)
>>>>
>>>> We could add the supplies to the pingroup subnodes of the pinctrl 
>>>> driver
>>>> to avoid that, but as Saravana already menioned, that would feel like
>>>> overkill.
>>>
> 
> I think this is actually a somewhat bad idea. Let me explain.
> 
> Nothing prevents the user to create a new DT node with two pins from 
> different IO domains. e.g. I could very well have the following:
> 
> """
> &pinctrl {
>      group {
>          two_iodomain_mux {
>               rockchip,pins = <0 RK_PA0 0 &pcfg_pull_none>,
>                           <3 RK_PB5 0 &pcfg_pull_none>;
>          };
>      };
> };
> """
> 
> for example if I have a device that uses GPIO0_A0 and GPIO3_B5 as gpios 
> and I need to configure their pinconf appropriately.
> 
> So from this, I guess we'd need to support multiple io-domains per node 
> (don't know the proper pinctrl subsystem name for that one sorry, the 
> two_iodomain_mux one in the above example).
> 
> We could also now group pinmux nodes by their io-domain, e.g.:
> 
> """
> &pinctrl {
>      bt656-io-domain {
>          power-supply = <&whatever>;
> 
>          only_pinmuxes_from_bt656 {
>          };
> 
>          only_pinmuxes_from_bt656_2 {
>          };
>      };
>      pmu1830-io-domain {
>          power-supply = <&something>;
> 
>          only_pinmuxes_from_pmu1830 {
>          };
> 
>          only_pinmuxes_from_pmu1830_2 {
>          };
>      };
>      [...]
> };
> """
> 
> This means we would need to go through all existing pinmux definition on 
> rockchip devices and check if they belong to the same io domain and if 
> they don't, split them in one or more pinmuxes for example.
> 
> Also, I think it'd be easier to ask board maintainers to only add a 
> power-supply property to all io-domains rather than to each and every 
> pinmux.
> 
> We could probably enforce that no subgroup other than the one named 
> after the ones named after the io-domain can be created on the driver 
> level as well. Not sure if it's wise but we could probably also check 
> that within a pingroup only pinmuxes belonging to the io-domain are listed.
> 
>>> So my comment yesterday was that it'd be an overkill to make every
>>> struct pin_desc into a device. But if you can split that rockchip
>>> pinctrl into two devices, that should be okay and definitely not an
>>> overkill.
>>>
>>> Maybe something like:
>>>
>>> pinctrl {
>>>      compatible = "rockchip,rk3568-pinctrl";
>>>      i2c0 {
>>>                  /omit-if-no-ref/
>>>                  i2c0_xfer: i2c0-xfer {
>>>                          rockchip,pins =
>>>                                  /* i2c0_scl */
>>>                                  <0 RK_PB1 1 &pcfg_pull_none_smt>,
>>>                                  /* i2c0_sda */
>>>                                  <0 RK_PB2 1 &pcfg_pull_none_smt>;
>>>                  };
>>>      }
>>>      ...
>>>      ...
>>>      pinctrl-io {
>>>          compatible = "rockchip,rk3568-pinctrl-io";
>>>          pmuio1-supply = <&vcc3v3_pmu>;
>>>          cam {
>>>              ....
>>>          }
>>>          ....
>>>          ....
>>> }
>>>
>>> So pinctrl will probe successfully and add it's child device
>>> pinctrl-io. i2c0 will probe once pinctrl is available. Then eventually
>>> the regulator will probe. And after all that, pinctrl-io would probe.
>>>
>>> This has no cycles and IMHO represents the hardware accurately. You
>>> have a pinctrl block and there's a sub component of it (pinctrl-io)
>>> that works differently and has additional dependencies.
>>>
>>> Any thoughts on this?
>>
> 
> Just to be clear that whether i2c0 is where the PMIC is is HW dependent, 
> so we cannot have that in the main SoC dtsi (on Rockchip we typically 
> have a bunch of those in the main SoC dtsi to avoid common nodes to be 
> copy-pasted all over the place).
> 
>> By making the IO domain device a child node of the pinctrl node we
>> wouldn't need a phandle from the pinctrl node to the IO domain node
>> anymore, but apart from that the approach is equivalent to what we have
>> already.
>>
> 
> Indeed, just one less item in the cyclic dependency but it's still there.
> 
>> Given that fw_devlink allows us to add the supplies directly to the
>> pinctrl node, I would prefer doing that. But as said, it doesn't solve
>> the problem.
>>
> 
> Absolutely.
> 
> The issue is that we have pinctrl that needs to probe for anything to 
> work really.
> 
> Considering that pinctrl pingroups requires (on the HW level) to be 
> linked to an IO domain to be working properly, the IO domain depending 
> on a regulator (which can have different voltages at runtime, hence why 
> this link is absolutely critical to not damage the SoC by having the IO 
> domain configured for a different voltage than provided by its 
> regulator), which is on a bus (i2c/spi) that needs a specific pinmux in 
> order to work.
> 
> Saravana gave one example of the cyclic dependency on the DT level 
> earlier. The issue isn't the DT-part of the cyclic dependency, it's that 
> the drivers actually also have this cyclic dependency, the i2c/spi 
> controller via its pinctrl default state and the pinctrl driver with a 
> dependency on a PMIC driver that could'nt have been probed yet because 
> its on the i2c bus. I don't see how we can not have a special property 
> in the DT binding for ignoring this cyclic dependency for one specific 
> loop. We cannot hardcode the driver to look for a specific compatible or 
> something like that because this is HW dependent, there's no rule on 
> which i2c/spi bus one needs to put their PMIC on. Maybe we could try to 
> look for the PMIC on child nodes of consumers of pinctrl (if possible 
> only when a cyclic dependency is detected) and bypass this dependency on 
> the regulator? Or maybe check if the parent of the PMIC of the IO domain 
> of the currently requested pingroup is the same as the consumer of the 
> currently requested pinmux within this pingroup?

This is why I think it makes the most sense to describe the initial I/O 
domain voltage as a property of the I/O domain, since that is most 
truthful to what is actually needed to initialise the hardware. Ideally 
we could then just use that initial configuration to probe successfully, 
and use a notifier to pick up the regulator if and when it does appear 
later (on the basis that the voltage should not be able to change 
*without* one). And otherwise if an initial voltage isn't specified then 
we can assume it's OK to wait for the regulator and query it as normal.

> I'm also wondering how this would play out if the PMIC isn't supplying 
> power to the IO domain the bus controller to which it's connected... but 
> I guess that's a HW design issue :)

Hopefully that would just be a sensible non-cyclic design that avoids 
this problem altogether. However there's nothing special about PMICs, 
this could equally apply if the I/O domain was supplied by a GPIO 
regulator or PWM regulator which used one of its own pins; the 
fundamental problem to solve is being able to determine the correct 
initial voltage setting for an I/O domain without having to perform any 
I/O via that domain itself. That is the physical dependency cycle which 
can exist here, regardless of how we address any other software 
dependencies between drivers within Linux.

Thanks,
Robin.

> 
> It's Friday evening here so hopefully my brain wasn't already on weekend 
> mode and I could convey properly everything I had in mind.
> 
> Cheers,
> Quentin
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
