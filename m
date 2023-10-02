Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910687B59DF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbjJBR6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjJBR6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:58:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F65CB7;
        Mon,  2 Oct 2023 10:57:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9281C15;
        Mon,  2 Oct 2023 10:58:34 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 349313F59C;
        Mon,  2 Oct 2023 10:57:54 -0700 (PDT)
Date:   Mon, 2 Oct 2023 18:57:51 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3 2/2] clk: scmi: add set/get_parent support
Message-ID: <ZRsEnze1htH_2ORf@pluto>
References: <20231001-scmi-clock-v2-v3-0-898bd92d8939@nxp.com>
 <20231001-scmi-clock-v2-v3-2-898bd92d8939@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001-scmi-clock-v2-v3-2-898bd92d8939@nxp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 12:38:44PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> SCMI v3.2 adds set/get parent clock commands, so update the clk driver
> to support them.
> 

Hi,

a few notes down below.

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/clk-scmi.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> index 2e1337b511eb..5aaca674830f 100644
> --- a/drivers/clk/clk-scmi.c
> +++ b/drivers/clk/clk-scmi.c
> @@ -24,6 +24,7 @@ struct scmi_clk {
>  	struct clk_hw hw;
>  	const struct scmi_clock_info *info;
>  	const struct scmi_protocol_handle *ph;
> +	struct clk_parent_data *parent_data;
>  };
>  
>  #define to_scmi_clk(clk) container_of(clk, struct scmi_clk, hw)
> @@ -78,6 +79,35 @@ static int scmi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>  	return scmi_proto_clk_ops->rate_set(clk->ph, clk->id, rate);
>  }
>  
> +static int scmi_clk_set_parent(struct clk_hw *hw, u8 parent_index)
> +{
> +	struct scmi_clk *clk = to_scmi_clk(hw);
> +
> +	return scmi_proto_clk_ops->parent_set(clk->ph, clk->id, parent_index);
> +}
> +
> +static u8 scmi_clk_get_parent(struct clk_hw *hw)
> +{
> +	struct scmi_clk *clk = to_scmi_clk(hw);
> +	u32 parent_id;
> +	int ret;
> +
> +	ret = scmi_proto_clk_ops->parent_get(clk->ph, clk->id, &parent_id);
> +	if (ret)
> +		return 0;
> +
> +	return parent_id;
> +}
> +

While testing using CLK Debugfs with CLOCK_ALLOW_WRITE_DEBUGFS 1 I
noticed that I can correctly change the clk_parent and then read back the
clk_possible_parents, BUT if I read clk_parent right after boot (OR
after loading the clk-scmi module) I cannot get back any value from debugfs
even though I can see the correct SCMI messages being exchanged from the
traces.

My guess was that, while scmi_clk_set_parent is invoked by the CLK core
with a parent_index that has been remapped by the core to the SCMI clock
domain ID, this is not done by scmi_clk_get_parent() so you are
returning to the clock framework as parent_id the raw SCMI clock domain
id as returned by the platform instead of the clk parent id used by the
core.

This does not happen after you issue at first a reparent because in that
case on the following read of clk_parent the CLK framework returns the last
value you have set that it had cached previously.

This fixes for me the issue:

---8<----

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 5aaca674830f..fd47232d4021 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -89,14 +89,21 @@ static int scmi_clk_set_parent(struct clk_hw *hw, u8 parent_index)
 static u8 scmi_clk_get_parent(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
-	u32 parent_id;
+	u32 parent_id, p_idx;
 	int ret;
 
 	ret = scmi_proto_clk_ops->parent_get(clk->ph, clk->id, &parent_id);
 	if (ret)
 		return 0;
 
-	return parent_id;
+	for (p_idx = 0; p_idx < clk->info->num_parents; p_idx++)
+		if (clk->parent_data[p_idx].index == parent_id)
+			break;
+
+	if (p_idx == clk->info->num_parents)
+		return 0;
+
+	return p_idx;
 }
 
 ----8<-----

 Not sure if there is a clever way to do it.

Aside from this, another inherent issue is that you cannot really return
an error from .get_parent() so if the SCMI get_parent ops should fail
(ex. timeout) you return 0... (and me too in the above fix) but this is due
to the CLK framework callback definition itself.

Thanks,
Cristian

